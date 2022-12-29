import 'package:equatable/equatable.dart';
import 'package:vacancies/feature/domain/entities/job_entity.dart';

abstract class CompanyJobState extends Equatable {
  const CompanyJobState();

  @override
  List<Object?> get props => [];
}

class CompanyJobEmpty extends CompanyJobState {
  @override
  List<Object?> get props => [];
}

class CompanyJobLoading extends CompanyJobState {
  final List<JobEntity> oldJobsList;
  final int companyId;

  const CompanyJobLoading(this.oldJobsList, {required this.companyId});
  @override
  List<Object> get props => [oldJobsList];
}

class CompanyJobLoaded extends CompanyJobState {
  final List<JobEntity> jobsList;

  const CompanyJobLoaded(this.jobsList);

  @override
  List<Object> get props => [jobsList];
}

class CompanyJobError extends CompanyJobState {
  final String message;

  const CompanyJobError({required this.message});

  @override
  List<Object?> get props => [message];
}
