import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vacancies/feature/domain/entities/company_entity.dart';
import 'package:vacancies/feature/domain/entities/job_entity.dart';
import 'package:vacancies/feature/presentation/bloc/company_list_cubit/company_list_cubit.dart';
import 'package:vacancies/feature/presentation/bloc/job_list_cubit/job_list_cubit.dart';

List<JobEntity> checkCondition(
    List<JobEntity> allJobs,
    List<String> indystryMultiSelect,
    String? cityDropDown,
    String query,
    bool sortAlphabet,
    BuildContext context) {
  final companyProvider = BlocProvider.of<CompanyListCubit>(context);
  List<CompanyEntity> selectedCompanyIndustry =
      companyProvider.selectedCompanyIndustry(indystryMultiSelect);
  final jobProvider = BlocProvider.of<JobListCubit>(context);
  List<JobEntity> industrySortJobs =
      jobProvider.industrySortJobs(selectedCompanyIndustry, allJobs);
  List<JobEntity> sortJobs = [];

  if (indystryMultiSelect.isNotEmpty && cityDropDown != null) {
    industrySortJobs.removeWhere((job) => job.city != cityDropDown);
    sortJobs = industrySortJobs;
  } else if (indystryMultiSelect.isEmpty && cityDropDown != null) {
    sortJobs = allJobs.where((job) => job.city == cityDropDown).toList();
  } else if (indystryMultiSelect.isNotEmpty && cityDropDown == null) {
    sortJobs = industrySortJobs;
  } else {
    sortJobs = allJobs;
  }
  (sortAlphabet == true)
      ? sortJobs.sort((a, b) {
          return a.title.toLowerCase().compareTo(b.title.toLowerCase());
        })
      : sortJobs;

  jobProvider.searchingJobs(sortJobs, allJobs, query, sortAlphabet,
      indystryMultiSelect, cityDropDown);

  return sortJobs;
}
