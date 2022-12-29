import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:vacancies/core/error/failure.dart';
import 'package:vacancies/core/usecases/usecaseParam.dart';
import 'package:vacancies/feature/domain/entities/job_entity.dart';
import 'package:vacancies/feature/domain/repositories/repository.dart';

class DeleteJob extends UseCaseParam<void, JobDel> {
  final Repository jobRepository;
  DeleteJob(
    this.jobRepository,
  );

  @override
  Future<Either<Failure, void>> call(JobDel params) async {
    return await jobRepository.deleteJob(params.jobDel);
  }
}

class JobDel extends Equatable {
  final JobEntity jobDel;

  const JobDel({required this.jobDel});

  @override
  List<Object> get props => [jobDel];
}
