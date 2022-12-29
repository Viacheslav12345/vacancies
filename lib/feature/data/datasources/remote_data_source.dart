import 'package:dio/dio.dart';
import 'package:vacancies/core/error/exception.dart';
import 'package:vacancies/feature/data/const.dart';
import 'package:vacancies/feature/data/models/company_model.dart';
import 'package:vacancies/feature/data/models/job_model.dart';
import 'package:vacancies/feature/domain/entities/company_entity.dart';
import 'package:vacancies/feature/domain/entities/job_entity.dart';
import 'package:http/http.dart' as http;

abstract class RemoteDataSource {
  Future<List<CompanyModel>> getAllCompanies();
  Future<List<JobModel>> getAllJobs();
  Future<List<JobModel>> getCompanyJobs(int companyId);
  Future<void> addCompany(Map<String, dynamic> company);
  Future<void> addJob(Map<String, dynamic> job);
  Future<void> deleteCompany(CompanyEntity company);
  Future<void> deleteJob(JobEntity job);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  var client = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      },
    ),
  );

  RemoteDataSourceImpl({required this.client});

  @override
  Future<List<CompanyModel>> getAllCompanies() async {
    final response = await client.get(pathCompanies);
    if (response.statusCode == 200) {
      final companies = response.data;
      return (companies['result'] as List)
          .map((company) => CompanyModel.fromJson(company))
          .toList();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<JobModel>> getAllJobs() => _getJobsFromUrl(pathJobs);

  @override
  Future<List<JobModel>> getCompanyJobs(int companyId) =>
      _getJobsFromUrl('$pathCompanies/$companyId/jobs/');

  Future<List<JobModel>> _getJobsFromUrl(String url) async {
    print(url);
    final response = await client.get(url);
    if (response.statusCode == 200) {
      final jobs = response.data;
      return ((jobs['result'] ?? []) as List)
          .map((job) => JobModel.fromJson(job))
          .toList();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<void> addCompany(Map<String, dynamic> company) async {
    final response =
        await client.post(pathCompanies, data: CompanyModel.fromJson(company));
    if (response.statusCode == 200) {
      print('Company $company added to Server: ');
    } else {
      throw ServerException();
    }
  }

  @override
  Future<void> addJob(Map<String, dynamic> job) async {
    final response = await client.post(pathJobs, data: JobModel.fromJson(job));
    if (response.statusCode == 200) {
      print('Job $job added to Server: ');
    } else {
      throw ServerException();
    }
  }

  @override
  Future<void> deleteCompany(CompanyEntity company) async {
    final companyId = company.id;
    final jsonString = company.toJson().toString();

    await http.delete(
      Uri.parse('$baseUrl$pathCompanies/$companyId'),
      body: jsonString,
    );
    print(jsonString);
  }

  @override
  Future<void> deleteJob(JobEntity job) async {
    final jobId = job.id;
    final jsonString = job.toJson().toString();

    await http.delete(
      Uri.parse('$baseUrl$pathCompanies/$jobId'),
      body: jsonString,
    );
    print(jsonString);
  }
}
