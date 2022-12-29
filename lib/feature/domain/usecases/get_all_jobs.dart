import 'package:dartz/dartz.dart';
import 'package:vacancies/core/error/failure.dart';
import 'package:vacancies/core/usecases/usecase.dart';
import 'package:vacancies/feature/domain/entities/job_entity.dart';
import 'package:vacancies/feature/domain/repositories/repository.dart';

class GetAllJobs extends UseCase<List<JobEntity>> {
  final Repository jobRepository;
  GetAllJobs(
    this.jobRepository,
  );

  @override
  Future<Either<Failure, List<JobEntity>>> call() async {
    return await jobRepository.getAllJobs();
  }
}
