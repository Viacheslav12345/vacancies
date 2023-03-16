import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:vacancies/core/error/failure.dart';
import 'package:vacancies/core/usecases/usecaseParam.dart';
import 'package:vacancies/feature/domain/entities/job_entity.dart';
import 'package:vacancies/feature/domain/repositories/repository.dart';

class GetJobs extends UseCaseParam<List<JobEntity>, JobsParams> {
  final Repository jobRepository;
  GetJobs(
    this.jobRepository,
  );

  @override
  Future<Either<Failure, List<JobEntity>>> call(JobsParams params) async {
    return await jobRepository.getJobs(params.companyId);
  }
}

class JobsParams extends Equatable {
  final int? companyId;

  const JobsParams([this.companyId]);

  @override
  List<Object> get props => [
        [companyId]
      ];
}
