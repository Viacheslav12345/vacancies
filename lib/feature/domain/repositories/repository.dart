import 'package:dartz/dartz.dart';
import 'package:vacancies/core/error/failure.dart';
import 'package:vacancies/feature/domain/entities/company_entity.dart';
import 'package:vacancies/feature/domain/entities/job_entity.dart';

abstract class Repository {
  Future<Either<Failure, List<CompanyEntity>>> getAllCompanies();
  Future<Either<Failure, List<JobEntity>>> getAllJobs();
  Future<Either<Failure, List<JobEntity>>> getCompanyJobs(int companyId);
  Future<Either<Failure, void>> addJob(Map<String, dynamic> job);
  Future<Either<Failure, void>> addCompany(Map<String, dynamic> company);
  Future<Either<Failure, void>> deleteJob(JobEntity job);
  Future<Either<Failure, void>> deleteCompany(CompanyEntity company);
}
