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

class JobLoading extends JobState {
  final List<JobEntity> oldJobsList;

  const JobLoading(this.oldJobsList);
  @override
  List<Object> get props => [oldJobsList];
}

class JobLoaded extends JobState {
  final List<JobEntity> jobsList;

  const JobLoaded(this.jobsList);

  @override
  List<Object> get props => [jobsList];
}

class JobError extends JobState {
  final String message;

  const JobError({required this.message});

  @override
  List<Object?> get props => [message];
}

class JobAdded extends JobState {
  final Map<String, dynamic> job;

  const JobAdded(this.job);

  @override
  List<Object> get props => [job];
}
