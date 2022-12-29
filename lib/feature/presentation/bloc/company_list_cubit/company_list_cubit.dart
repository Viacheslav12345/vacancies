// ignore_for_file: constant_identifier_names

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vacancies/core/error/failure.dart';
import 'package:vacancies/feature/domain/entities/company_entity.dart';
import 'package:vacancies/feature/domain/usecases/add_company.dart';
import 'package:vacancies/feature/domain/usecases/delete_company.dart';
import 'package:vacancies/feature/domain/usecases/get_all_companies.dart';
import 'package:vacancies/feature/presentation/bloc/company_list_cubit/company_list_state.dart';

const SERVER_FAILURE_MESSAGE = 'Server Failure';
const CASHED_FAILURE_MESSAGE = 'Cashe Failure';

class CompanyListCubit extends Cubit<CompanyState> {
  final GetAllCompanies getAllCompanies;
  final AddCompany addOneCompany;
  final DeleteCompany deleteOneCompany;

  CompanyListCubit(this.addOneCompany, this.deleteOneCompany,
      {required this.getAllCompanies})
      : super(CompanyEmpty());

  void loadCompany() async {
    if (state is CompanyLoading) return;

    final currentState = state;
    var oldCompanies = <CompanyEntity>[];

    if (currentState is CompanyLoaded) {
      oldCompanies = currentState.companyList;
    }
    emit(CompanyLoading(oldCompanies));

    final failureOrCompany = await getAllCompanies();

    failureOrCompany.fold(
        (error) => emit(
              CompanyError(message: _mapFailureToMessage(error)),
            ), (character) {
      final companies = (state as CompanyLoading).oldCompanyList;
      companies.addAll(character);
      emit(CompanyLoaded(companies));
    });
  }

  void addCompany(Map<String, dynamic> company) async {
    final failureOrCompany = await addOneCompany(Company(company: company));

    failureOrCompany.fold(
        (error) => emit(
              CompanyError(message: _mapFailureToMessage(error)),
            ), (character) {
      emit(CompanyAdded(company));
    });

    loadCompany();
  }

  void deleteCompany(CompanyEntity companyDel) async {
    final failureOrCompany =
        await deleteOneCompany(CompanyDel(companyDel: companyDel));

    failureOrCompany.fold(
        (error) => emit(
              CompanyError(message: _mapFailureToMessage(error)),
            ), (character) {
      emit(CompanyDeleted(companyDel));
    });

    loadCompany();
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
