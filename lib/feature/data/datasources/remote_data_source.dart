import 'package:dio/dio.dart';
import 'package:vacancies/core/error/exception.dart';
import 'package:vacancies/feature/data/const.dart';
import 'package:vacancies/feature/data/models/company_model.dart';
import 'package:vacancies/feature/data/models/job_model.dart';

abstract class RemoteDataSource {
  Future<List<CompanyModel>> getAllCompanies();
  Future<List<JobModel>> getAllJobs();
  Future<List<JobModel>> getCompanyJobs(int companyId);
  Future<void> addCompany(Map<String, dynamic> company);
  Future<void> addJob(Map<String, dynamic> job);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  var client = Dio(BaseOptions(baseUrl: baseUrl));

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
}
