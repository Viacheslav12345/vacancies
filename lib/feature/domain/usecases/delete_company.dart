import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:vacancies/core/error/failure.dart';
import 'package:vacancies/core/usecases/usecaseParam.dart';
import 'package:vacancies/feature/domain/entities/company_entity.dart';
import 'package:vacancies/feature/domain/repositories/repository.dart';

class DeleteCompany extends UseCaseParam<void, CompanyDel> {
  final Repository companyRepository;
  DeleteCompany(
    this.companyRepository,
  );

  @override
  Future<Either<Failure, void>> call(CompanyDel params) async {
    return await companyRepository.deleteCompany(params.companyDel);
  }
}

class CompanyDel extends Equatable {
  final CompanyEntity companyDel;

  const CompanyDel({required this.companyDel});

  @override
  List<Object> get props => [companyDel];
}
