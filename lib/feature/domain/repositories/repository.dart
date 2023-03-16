import 'package:dartz/dartz.dart';
import 'package:vacancies/core/error/failure.dart';
import 'package:vacancies/feature/domain/entities/company_entity.dart';
import 'package:vacancies/feature/domain/entities/job_entity.dart';

abstract class Repository {
  Future<Either<Failure, List<CompanyEntity>>> getAllCompanies();
  Future<Either<Failure, List<JobEntity>>> getJobs([int? companyId]);
  Future<Either<Failure, int?>> addJob(JobEntity job);
  Future<Either<Failure, int?>> addCompany(CompanyEntity company);
  Future<Either<Failure, bool>> deleteJob(JobEntity job);
  Future<Either<Failure, bool>> deleteCompany(CompanyEntity company);
}
