import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:vacancies/core/error/failure.dart';
import 'package:vacancies/core/usecases/usecaseParam.dart';
import 'package:vacancies/feature/domain/entities/job_entity.dart';
import 'package:vacancies/feature/domain/repositories/repository.dart';

class GetCompanyJobs extends UseCaseParam<List<JobEntity>, CompanyJobsParams> {
  final Repository jobRepository;
  GetCompanyJobs(
    this.jobRepository,
  );

  @override
  Future<Either<Failure, List<JobEntity>>> call(
      CompanyJobsParams params) async {
    return await jobRepository.getCompanyJobs(params.companyId);
  }
}

class CompanyJobsParams extends Equatable {
  final int companyId;

  const CompanyJobsParams({required this.companyId});

  @override
  List<Object> get props => [companyId];
}
