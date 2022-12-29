import 'package:dartz/dartz.dart';
import 'package:vacancies/core/error/failure.dart';
import 'package:vacancies/core/usecases/usecase.dart';
import 'package:vacancies/feature/domain/entities/company_entity.dart';
import 'package:vacancies/feature/domain/repositories/repository.dart';

class GetAllCompanies extends UseCase<List<CompanyEntity>> {
  final Repository companyRepository;
  GetAllCompanies(
    this.companyRepository,
  );

  @override
  Future<Either<Failure, List<CompanyEntity>>> call() async {
    return await companyRepository.getAllCompanies();
  }
}
