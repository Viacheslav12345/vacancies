// ignore_for_file: constant_identifier_names

import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vacancies/core/error/failure.dart';
import 'package:vacancies/feature/domain/entities/company_entity.dart';
import 'package:vacancies/feature/domain/usecases/add_company.dart';
import 'package:vacancies/feature/domain/usecases/delete_company.dart';
import 'package:vacancies/feature/domain/usecases/delete_job.dart';
import 'package:vacancies/feature/domain/usecases/get_all_companies.dart';
import 'package:vacancies/feature/presentation/bloc/company_list_cubit/company_list_state.dart';

const SERVER_FAILURE_MESSAGE = 'Server Failure';
const CASHED_FAILURE_MESSAGE = 'Cashe Failure';

class CompanyListCubit extends Cubit<CompanyState> {
  final GetAllCompanies getAllCompanies;
  final AddCompany addOneCompany;
  final DeleteCompany deleteOneCompany;
  final DeleteJob deleteOneJob;

  CompanyListCubit(this.addOneCompany, this.deleteOneCompany, this.deleteOneJob,
      {required this.getAllCompanies})
      : super(CompanyEmpty());

  void loadCompany() async {
    emit(const CompanyLoading([]));

    final failureOrCompany = await getAllCompanies();

    failureOrCompany.fold(
        (error) => emit(
              CompanyError(message: _mapFailureToMessage(error)),
            ), (character) {
      emit(CompanyLoaded(character));
    });
  }

  Future<int?> addCompany(CompanyEntity company) async {
    int? responseCompanyId;
    final currentState = state;
    var companyNewList = <CompanyEntity>[];

    if (currentState is CompanyLoaded) {
      companyNewList = currentState.companyList;
    } else if (currentState is CompanyLoading) {
      companyNewList = currentState.oldCompnyList;
    }
    emit(CompanyLoading(companyNewList));
    final failureOrCompany = await addOneCompany(Company(company: company));

    failureOrCompany.fold(
        (error) => emit(
              CompanyError(message: _mapFailureToMessage(error)),
            ), (response) {
      responseCompanyId = response;
      company.id = responseCompanyId;
      if (company.id != null) {
        companyNewList.insert(0, company);
      }
      emit(CompanyLoaded(companyNewList));
    });
    return responseCompanyId;
  }

  Future<bool> deleteCompany(CompanyEntity companyDel) async {
    bool responseDelete = false;
    final currentState = state;
    var companyNewList = <CompanyEntity>[];

    if (currentState is CompanyLoaded) {
      companyNewList = currentState.companyList;
    } else if (currentState is CompanyLoading) {
      companyNewList = currentState.oldCompnyList;
    }
    emit(CompanyLoading(companyNewList));
    final failureOrCompany =
        await deleteOneCompany(CompanyDel(companyDel: companyDel));

    failureOrCompany.fold((error) {
      emit(CompanyError(message: _mapFailureToMessage(error)));
      responseDelete = false;
    }, (response) {
      responseDelete = response;
      if (responseDelete == true) {
        companyNewList.remove(companyDel);
      }
      emit(CompanyLoaded(companyNewList));
    });
    return responseDelete;
  }

  String? companyName(int companyId) {
    String? companyName = '';
    final currentState = state;

    if (currentState is CompanyLoaded) {
      companyName = currentState.companyList
          .firstWhereOrNull((company) => company.id == companyId)
          ?.name;
    }
    return companyName;
  }

  List<String> companyIndustry() {
    List<String> uniqueCompanyIndustry = [];
    Set<String> seen = {};
    final currentState = state;
    if (currentState is CompanyLoaded) {
      uniqueCompanyIndustry = currentState.companyList
          .map((company) => company.industry)
          .toList()
          .where((industry) => seen.add(industry))
          .toList();
    }
    return uniqueCompanyIndustry;
  }

  List<CompanyEntity> selectedCompanyIndustry(
      List<String> indystryMultiSelect) {
    List<CompanyEntity> selectedCompanyIndustry = [];
    final currentState = state;

    if (currentState is CompanyLoaded) {
      final companyList = currentState.companyList;
      for (var industry in indystryMultiSelect) {
        selectedCompanyIndustry.addAll(
            companyList.where((company) => company.industry == industry));
      }
    }
    return selectedCompanyIndustry;
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
