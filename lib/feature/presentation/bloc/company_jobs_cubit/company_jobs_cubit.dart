// ignore_for_file: constant_identifier_names

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vacancies/core/error/failure.dart';
import 'package:vacancies/feature/domain/entities/job_entity.dart';
import 'package:vacancies/feature/domain/usecases/get_company_jobs.dart';
import 'package:vacancies/feature/presentation/bloc/company_jobs_cubit/company_jobs_state.dart';
import 'package:vacancies/feature/presentation/bloc/job_list_cubit/job_list_state.dart';

const SERVER_FAILURE_MESSAGE = 'Server Failure';
const CASHED_FAILURE_MESSAGE = 'Cashe Failure';

class CompanyJobsListCubit extends Cubit<CompanyJobState> {
  final GetCompanyJobs getCompanyJobs;
  CompanyJobsListCubit({required this.getCompanyJobs})
      : super(CompanyJobEmpty());

  void loadCompanyJob(companyId) async {
    if (state is JobLoading) return;

    final currentState = state;

    var oldCompanyJobs = <JobEntity>[];
    if (currentState is CompanyJobLoaded) {
      oldCompanyJobs = currentState.jobsList;
    }

    emit(CompanyJobLoading(oldCompanyJobs, companyId: companyId));

    final failureOrJob = await getCompanyJobs(
      CompanyJobsParams(companyId: companyId),
    );

    //!!!!!!

    failureOrJob.fold(
        (error) => emit(
              CompanyJobError(message: _mapFailureToMessage(error)),
            ), (character) {
      final companyJobs = (state as CompanyJobLoading).oldJobsList;
      companyJobs.addAll(character);
      emit(CompanyJobLoaded(companyJobs));
    });
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
