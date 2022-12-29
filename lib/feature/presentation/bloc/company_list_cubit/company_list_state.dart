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
  final List<CompanyEntity> oldCompanyList;

  const CompanyLoading(this.oldCompanyList);
  @override
  List<Object> get props => [oldCompanyList];
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

class CompanyAdded extends CompanyState {
  final Map<String, dynamic> company;

  const CompanyAdded(this.company);

  @override
  List<Object> get props => [company];
}

class CompanyDeleted extends CompanyState {
  final CompanyEntity company;

  const CompanyDeleted(this.company);

  @override
  List<Object> get props => [company];
}
