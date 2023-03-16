import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vacancies/common/app_colors.dart';
import 'package:vacancies/feature/domain/entities/job_entity.dart';
import 'package:vacancies/feature/presentation/bloc/job_list_cubit/job_list_cubit.dart';
import 'package:vacancies/feature/presentation/bloc/job_list_cubit/job_list_state.dart';
import 'package:vacancies/feature/presentation/widgets/add_company_form.dart';
import 'package:vacancies/feature/presentation/widgets/add_job_form.dart';
import 'package:vacancies/feature/presentation/widgets/custom_search_delegate.dart';

class FloatingActionButtons extends StatelessWidget {
  const FloatingActionButtons(this.tabControlIndex, {Key? key})
      : super(key: key);
  final int tabControlIndex;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FloatingActionButton(
            heroTag: 'find',
            backgroundColor: (tabControlIndex == 0)
                ? AppColors.companyColor
                : AppColors.jobColor,
            tooltip: 'Find',
            child: const Icon(Icons.find_in_page),
            onPressed: () {
              final jobProvider = BlocProvider.of<JobListCubit>(context);
              final currentState = jobProvider.state;
              List<JobEntity> allJobs = [];
              String query = '';
              bool sortAlphabet = false;

              if (currentState is JobsLoaded) {
                allJobs = currentState.jobsList;
              } else if (currentState is JobsSearching) {
                final sortJobs = currentState.jobsSearching;
                allJobs = currentState.alljobs;
                query = currentState.query;
                sortAlphabet = currentState.sortAlphabet;
                final indystryMultiSelect = currentState.indystryMultiSelect;
                final cityDropDown = currentState.cityDropDown;

                jobProvider.searchingJobs(sortJobs, allJobs, query,
                    sortAlphabet, indystryMultiSelect, cityDropDown);
              }
              showSearch(
                context: context,
                delegate: CustomSearchDelegate(allJobs),
                query: query,
              );
            },
          ),
          FloatingActionButton(
            heroTag: null,
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => (tabControlIndex == 0)
                        ? const AddCompanyForm()
                        : const AddJobForm(null),
                  ));
            },
            backgroundColor: (tabControlIndex == 0)
                ? AppColors.companyColor
                : AppColors.jobColor,
            tooltip: 'Add',
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
