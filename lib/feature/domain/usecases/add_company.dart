import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:vacancies/core/error/failure.dart';
import 'package:vacancies/core/usecases/usecaseParam.dart';
import 'package:vacancies/feature/domain/repositories/repository.dart';

class AddCompany extends UseCaseParam<void, Company> {
  final Repository companyRepository;
  AddCompany(
    this.companyRepository,
  );

  @override
  Future<Either<Failure, void>> call(Company params) async {
    return await companyRepository.addCompany(params.company);
  }
}

class Company extends Equatable {
  final Map<String, dynamic> company;

  const Company({required this.company});

  @override
  List<Object> get props => [company];
}
