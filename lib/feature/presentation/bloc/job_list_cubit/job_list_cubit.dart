// ignore_for_file: constant_identifier_names

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vacancies/core/error/failure.dart';
import 'package:vacancies/feature/domain/entities/company_entity.dart';
import 'package:vacancies/feature/domain/entities/job_entity.dart';
import 'package:vacancies/feature/domain/usecases/add_job.dart';
import 'package:vacancies/feature/domain/usecases/delete_job.dart';
import 'package:vacancies/feature/domain/usecases/get_jobs.dart';
import 'package:vacancies/feature/presentation/bloc/job_list_cubit/job_list_state.dart';

const SERVER_FAILURE_MESSAGE = 'Server Failure';
const CASHED_FAILURE_MESSAGE = 'Cashe Failure';

class JobListCubit extends Cubit<JobState> {
  final GetJobs getJobs;
  final AddJob addOneJob;
  final DeleteJob deleteOneJob;
  JobListCubit(this.addOneJob, this.deleteOneJob, {required this.getJobs})
      : super(JobEmpty());

  void loadJob(/*[companyId]*/) async {
    emit(const JobsLoading([]));

    final failureOrJob = await getJobs(const JobsParams(/*[companyId]*/));

    failureOrJob.fold(
        (error) => emit(
              JobError(message: _mapFailureToMessage(error)),
            ), (character) {
      emit(JobsLoaded(character));
    });
  }

  Future<int?> addJob(JobEntity job) async {
    int? responseJobId;
    final currentState = state;
    var jobsList = <JobEntity>[];

    if (currentState is JobsLoaded) {
      jobsList = currentState.jobsList;
    } else if (currentState is JobsSearching) {
      jobsList = currentState.alljobs;
    }
    emit(JobsLoading(jobsList));

    final failureOrJob = await addOneJob(Job(job: job));

    failureOrJob.fold(
        (error) => emit(
              JobError(message: _mapFailureToMessage(error)),
            ), (response) {
      responseJobId = response;
      job.id = responseJobId;
      if (job.id != null) {
        jobsList.insert(0, job);
      }
      emit(JobsLoaded(jobsList));
    });
    return responseJobId;
  }

  Future<bool> deleteJob(JobEntity jobDel) async {
    bool responseDelete = false;

    final currentState = state;
    var jobsList = <JobEntity>[];

    if (currentState is JobsLoaded) {
      jobsList = currentState.jobsList;
    } else if (currentState is JobsLoading) {
      jobsList = currentState.oldJobsList;
    }
    emit(JobsLoading(jobsList));
    final failureOrJob = await deleteOneJob(JobDel(jobDel: jobDel));

    failureOrJob.fold((error) {
      emit(JobError(message: _mapFailureToMessage(error)));
      responseDelete = false;
    }, (response) {
      responseDelete = response;
      if (response == true) {
        jobsList.remove(jobDel);
      }
      emit(JobsLoaded(jobsList));
    });
    return responseDelete;
  }

  List<String> cityJobs() {
    List<String> cityJobs = [];
    List<String> cityJobsDisabled = []; //!!!!!!!!!!!!!!!!!!!!!!!!!
    Set<String> seen = {};
    var currentState = state;

    Future.delayed(const Duration(seconds: 1));

    if (currentState is JobsLoaded) {
      cityJobs = currentState.jobsList
          .map((job) => job.city)
          .toList()
          .where((city) => seen.add(city))
          .toList();
    }

    if (currentState is JobsSearching) {
      cityJobs = currentState.alljobs
          .map((job) => job.city)
          .toList()
          .where((city) => seen.add(city))
          .toList();
      //   cityJobsDisabled = currentState.jobsSearching
      //       .map((job) => job.city)
      //       .toList()
      //       .where((city) => seen.add(city))
      //       .toList();
    }
    return cityJobs;
  }

  List<JobEntity> industrySortJobs(
      List<CompanyEntity> selectedCompanyIndustry, List<JobEntity> allJobs) {
    List<JobEntity> industrySortJobs = [];
    for (var company in selectedCompanyIndustry) {
      industrySortJobs
          .addAll(allJobs.where((job) => job.companyId == company.id).toSet());
    }
    return industrySortJobs;
  }

  void searchingJobs(
    List<JobEntity> sortJobs,
    List<JobEntity> allJobs,
    String query,
    bool sortAlphabet,
    List<String> indystryMultiSelect,
    String? cityDropDown,
  ) {
    emit(JobsSearching(sortJobs, allJobs, query, sortAlphabet,
        indystryMultiSelect, cityDropDown));
  }

  void endSearch(List<JobEntity> allJobs) {
    emit(JobsLoaded(allJobs));
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
