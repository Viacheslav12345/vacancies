import 'package:equatable/equatable.dart';
import 'package:vacancies/feature/domain/entities/job_entity.dart';

abstract class JobState extends Equatable {
  const JobState();

  @override
  List<Object?> get props => [];
}

class JobEmpty extends JobState {
  @override
  List<Object?> get props => [];
}

class JobsLoading extends JobState {
  final List<JobEntity> oldJobsList;

  const JobsLoading(this.oldJobsList);

  @override
  List<Object?> get props => [oldJobsList];
}

class JobsLoaded extends JobState {
  final List<JobEntity> jobsList;
  const JobsLoaded(this.jobsList);

  @override
  List<Object> get props => [jobsList];
}

// class JobsSearched extends JobState {
//   final List<JobEntity> jobsSearched;
//   final String query;

//   const JobsSearched(this.jobsSearched, this.query);
//   @override
//   List<Object> get props => [jobsSearched, query];
// }

class JobsSearching extends JobState {
  final List<JobEntity> jobsSearching;
  final List<JobEntity> alljobs;
  final String query;
  final bool sortAlphabet;
  final List<String> indystryMultiSelect;
  final String? cityDropDown;

  const JobsSearching(this.jobsSearching, this.alljobs, this.query,
      this.sortAlphabet, this.indystryMultiSelect, this.cityDropDown);
  @override
  List<dynamic> get props => [
        jobsSearching,
        alljobs,
        query,
        sortAlphabet,
        indystryMultiSelect,
        cityDropDown
      ];
}

class JobError extends JobState {
  final String message;
  const JobError({required this.message});

  @override
  List<Object?> get props => [message];
}
