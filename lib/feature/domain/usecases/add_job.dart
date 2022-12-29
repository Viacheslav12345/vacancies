import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:vacancies/core/error/failure.dart';
import 'package:vacancies/core/usecases/usecaseParam.dart';
import 'package:vacancies/feature/domain/repositories/repository.dart';

class AddJob extends UseCaseParam<void, Job> {
  final Repository jobRepository;
  AddJob(
    this.jobRepository,
  );

  @override
  Future<Either<Failure, void>> call(Job params) async {
    return await jobRepository.addJob(params.job);
  }
}

class Job extends Equatable {
  final Map<String, dynamic> job;

  const Job({required this.job});

  @override
  List<Object> get props => [job];
}
