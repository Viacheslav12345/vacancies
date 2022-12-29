// ignore_for_file: constant_identifier_names

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vacancies/core/error/failure.dart';
import 'package:vacancies/feature/domain/entities/job_entity.dart';
import 'package:vacancies/feature/domain/usecases/add_job.dart';
import 'package:vacancies/feature/domain/usecases/get_all_jobs.dart';
import 'package:vacancies/feature/presentation/bloc/job_list_cubit/job_list_state.dart';

const SERVER_FAILURE_MESSAGE = 'Server Failure';
const CASHED_FAILURE_MESSAGE = 'Cashe Failure';

class JobListCubit extends Cubit<JobState> {
  final GetAllJobs getAllJobs;
  final AddJob addOneJob;
  JobListCubit(this.addOneJob, {required this.getAllJobs}) : super(JobEmpty());

  void loadJob() async {
    if (state is JobLoading) return;

    final currentState = state;

    var oldJobs = <JobEntity>[];
    if (currentState is JobLoaded) {
      oldJobs = currentState.jobsList;
    }

    emit(JobLoading(oldJobs));

    final failureOrJob = await getAllJobs();

    failureOrJob.fold(
        (error) => emit(
              JobError(message: _mapFailureToMessage(error)),
            ), (character) {
      final jobs = (state as JobLoading).oldJobsList;
      jobs.addAll(character);
      emit(JobLoaded(jobs));
    });
  }

  void addJob(Map<String, dynamic> job) async {
    final failureOrJob = await addOneJob(Job(job: job));

    failureOrJob.fold(
        (error) => emit(
              JobError(message: _mapFailureToMessage(error)),
            ), (character) {
      emit(JobAdded(job));
    });

    loadJob();
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CASHED_FAILURE_MESSAGE;
      default:
        return 'Unexpected Error';
    }
  }
}
