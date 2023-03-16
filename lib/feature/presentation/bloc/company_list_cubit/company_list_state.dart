// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:vacancies/feature/domain/entities/company_entity.dart';

abstract class CompanyState extends Equatable {
  const CompanyState();

  @override
  List<Object?> get props => [];
}

class CompanyEmpty extends CompanyState {
  @override
  List<Object?> get props => [];
}

class CompanyLoading extends CompanyState {
  final List<CompanyEntity> oldCompnyList;
  const CompanyLoading(this.oldCompnyList);
  @override
  List<Object> get props => [oldCompnyList];
}

class CompanyLoaded extends CompanyState {
  final List<CompanyEntity> companyList;

  const CompanyLoaded(this.companyList);

  @override
  List<Object> get props => [companyList];
}

class CompanyError extends CompanyState {
  final String message;

  const CompanyError({required this.message});

  @override
  List<Object?> get props => [message];
}
