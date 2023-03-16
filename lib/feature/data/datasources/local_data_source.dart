// ignore_for_file: constant_identifier_names

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vacancies/core/error/exception.dart';
import 'package:vacancies/feature/data/models/company_model.dart';
import 'package:vacancies/feature/data/models/job_model.dart';

abstract class LocalDataSource {
  Future<List<JobModel>> getLastJobsFromCache();
  Future<void> jobsToCache(List<JobModel> jobs);

  Future<List<CompanyModel>> getLastCompaniesFromCache();
  Future<void> companiesToCache(List<CompanyModel> companies);
}

const CACHED_COMPANIES_LIST = 'CACHED_COMPANIES_LIST';
const CACHED_JOBS_LIST = 'CACHED_JOBS_LIST';

class LocalDataSourceImpl implements LocalDataSource {
  final SharedPreferences sharedPreferences;

  LocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> companiesToCache(List<CompanyModel> companies) {
    final List<String> jsonCompaniesList =
        companies.map((company) => json.encode(company.toJson())).toList();
    sharedPreferences.setStringList(CACHED_COMPANIES_LIST, jsonCompaniesList);
    print('Companies to write Cache: ${jsonCompaniesList.length}');
    return Future<List<String>>.value(jsonCompaniesList);
  }

  @override
  Future<List<CompanyModel>> getLastCompaniesFromCache() {
    final jsonCompaniesList =
        sharedPreferences.getStringList(CACHED_COMPANIES_LIST) as List<String>;
    // log(jsonCompaniesList.toString());
    if (jsonCompaniesList.isNotEmpty) {
      return Future.value(jsonCompaniesList
          .map((company) => CompanyModel.fromJson(json.decode(company)))
          .toList());
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> jobsToCache(List<JobModel> jobs) {
    final List<String> jsonJobsList =
        jobs.map((job) => json.encode(job.toJson())).toList();
    sharedPreferences.setStringList(CACHED_JOBS_LIST, jsonJobsList);
    print('Jobs to write Cache: ${jsonJobsList.length}');
    return Future<List<String>>.value(jsonJobsList);
  }

  @override
  Future<List<JobModel>> getLastJobsFromCache() {
    final jsonJobsList =
        sharedPreferences.getStringList(CACHED_JOBS_LIST) ?? [] as List<String>;
    // log(jsonJobsList.toString());
    if (jsonJobsList.isNotEmpty) {
      return Future.value(jsonJobsList
          .map((job) => JobModel.fromJson(json.decode(job)))
          .toList());
    } else {
      throw CacheException();
    }
  }
}
