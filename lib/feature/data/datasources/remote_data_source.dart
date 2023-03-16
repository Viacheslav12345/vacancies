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
  Future<List<JobModel>> getJobs([int? companyId]);
  Future<int> addCompany(CompanyEntity company);
  Future<int> addJob(JobEntity job);
  Future<bool> deleteCompany(CompanyEntity company);
  Future<bool> deleteJob(JobEntity job);
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
    print(pathCompanies);
    if (response.statusCode == 200) {
      final companies = response.data;
      return (companies['result'] as List)
          .map((company) => CompanyModel.fromJson(company))
          .toList();
    } else {
      throw ServerException(response.statusMessage);
    }
  }

  @override
  Future<List<JobModel>> getJobs([int? companyId]) => (companyId != null)
      ? _getJobsFromUrl('$pathCompanies/$companyId/jobs/')
      : _getJobsFromUrl(pathJobs);

  Future<List<JobModel>> _getJobsFromUrl(String url) async {
    print(url);
    final response = await client.get(url);
    if (response.statusCode == 200) {
      final jobs = response.data;
      return ((jobs['result'] ?? []) as List)
          .map((job) => JobModel.fromJson(job))
          .toList();
    } else {
      throw ServerException(response.statusMessage);
    }
  }

  @override
  Future<int> addCompany(CompanyEntity company) async {
    final response = await client.post(pathCompanies, data: company.toJson());
    if (response.statusCode == 200) {
      print('Company $company added to Server: ');
    } else {
      throw ServerException(response.statusMessage);
    }
    return response.data['id'];
  }

  @override
  Future<int> addJob(JobEntity job) async {
    final response = await client.post(pathJobs, data: job);
    if (response.statusCode == 200) {
      print('Job $job added to Server: ');
    } else {
      throw ServerException(response.statusMessage);
    }
    return response.data['id'];
  }

  @override
  Future<bool> deleteCompany(CompanyEntity company) async {
    bool responseStatus = false;
    final companyId = company.id;
    final jsonString = company.toJson().toString();

    final response = await http.delete(
      Uri.parse('$baseUrl$pathCompanies/$companyId'),
      body: jsonString,
    );
    if (response.statusCode == 200) {
      responseStatus = true;
      print('Компанія видалена з сервера: $jsonString');
    } else {
      throw ServerException(response.reasonPhrase);
    }
    return responseStatus;
  }

  @override
  Future<bool> deleteJob(JobEntity job) async {
    bool responseStatus = false;

    final jobId = job.id;
    final jsonString = job.toJson().toString();

    final response = await http.delete(
      Uri.parse('$baseUrl$pathJobs/$jobId'),
      body: jsonString,
    );

    if (response.statusCode == 200) {
      print('Вакансія видалена з сервера: ${jsonString}');
    } else {
      throw ServerException(response.reasonPhrase);
    }
    return responseStatus;
  }
}
