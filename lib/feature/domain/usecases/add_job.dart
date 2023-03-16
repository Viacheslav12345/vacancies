import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:vacancies/core/error/failure.dart';
import 'package:vacancies/core/usecases/usecaseParam.dart';
import 'package:vacancies/feature/domain/entities/job_entity.dart';
import 'package:vacancies/feature/domain/repositories/repository.dart';

class AddJob extends UseCaseParam<void, Job> {
  final Repository jobRepository;
  AddJob(
    this.jobRepository,
  );

  @override
  Future<Either<Failure, int?>> call(Job params) async {
    return await jobRepository.addJob(params.job);
  }
}

class Job extends Equatable {
  final JobEntity job;

  const Job({required this.job});

  @override
  List<Object> get props => [job];
}
