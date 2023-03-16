import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vacancies/common/horizontal_gradient_style.dart';
import 'package:vacancies/common/app_colors.dart';
import 'package:vacancies/feature/domain/entities/job_entity.dart';
import 'package:vacancies/feature/presentation/bloc/company_list_cubit/company_list_cubit.dart';
import 'package:vacancies/feature/presentation/bloc/job_list_cubit/job_list_cubit.dart';
import 'package:vacancies/feature/presentation/bloc/job_list_cubit/job_list_state.dart';
import 'package:vacancies/feature/presentation/widgets/check_filter_condition.dart';
import 'package:vacancies/feature/presentation/widgets/searched_list.dart';

class CustomSearchDelegate extends SearchDelegate {
  List<JobEntity> allJobs;
  CustomSearchDelegate(
    this.allJobs,
  ) : super(
          searchFieldLabel: ('Посада чи компанія'), /*searchFieldStyle: */
        );

  final _suggestions = [
    'Developer',
    'Apple',
    'Google',
    'Junior',
    'Middle',
    'Senior',
    'Nova poshta',
    'Java',
    'Flutter',
  ];
  List<JobEntity> sortJobs = [];
  List<String> indystryMultiSelect = [];
  String? cityDropDown;
  bool sortAlphabet = false;

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
          showSuggestions(context);
        },
        icon: const Icon(
          Icons.cancel_sharp,
          size: 35,
        ),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
        if (indystryMultiSelect.isEmpty &&
            cityDropDown == null &&
            query == '' &&
            sortAlphabet == false) {
          BlocProvider.of<JobListCubit>(context).endSearch(allJobs);
        } else {
          BlocProvider.of<JobListCubit>(context).searchingJobs(sortJobs,
              allJobs, query, sortAlphabet, indystryMultiSelect, cityDropDown);
        }
      },
      icon: const Icon(Icons.arrow_back_outlined),
      tooltip: 'Back',
    );
  }

  Widget _showFilteredResult() {
    return BlocBuilder<JobListCubit, JobState>(
      builder: ((context, state) {
        final companyProvider = BlocProvider.of<CompanyListCubit>(context);

        if (state is JobsLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is JobsLoaded) {
          sortJobs =
              // checkCondition(allJobs, indystryMultiSelect, cityDropDown,
              //         query, sortAlphabet, context) //!!!!!!!!!!!!!
              allJobs.where((job) {
            int companyId = job.companyId;
            var companyName = companyProvider.companyName(companyId);
            return ((job.title.toLowerCase().contains(query.toLowerCase())) ||
                ((companyName != null)
                    ? (companyName.toLowerCase().contains(query.toLowerCase()))
                    : false));
          }).toList();

          if (sortJobs.isEmpty) {
            return _showErrorText(
                "Вакансій чи компаній з таким ім'ям не знайдено!");
          }
          return SearchedList(
            sortJobs: sortJobs,
            allJobs: allJobs,
            query: query,
            sortAlphabet: sortAlphabet,
            indystryMultiSelect: indystryMultiSelect,
            cityDropDown: cityDropDown,
          );
        } else if (state is JobsSearching) {
          indystryMultiSelect = state.indystryMultiSelect;
          cityDropDown = state.cityDropDown;
          sortAlphabet = state.sortAlphabet;

          sortJobs = checkCondition(allJobs, indystryMultiSelect, cityDropDown,
                  query, sortAlphabet, context)
              .where((job) {
            int companyId = job.companyId;
            var companyName = companyProvider.companyName(companyId);
            return ((job.title.toLowerCase().contains(query.toLowerCase())) ||
                ((companyName != null)
                    ? (companyName.toLowerCase().contains(query.toLowerCase()))
                    : false));
          }).toList();

          if (sortJobs.isEmpty) {
            return _showErrorText(
                "Вакансій чи компаній\n з таким ім'ям не знайдено!");
          }
          return SearchedList(
            sortJobs: sortJobs,
            allJobs: allJobs,
            query: query,
            sortAlphabet: sortAlphabet,
            indystryMultiSelect: indystryMultiSelect,
            cityDropDown: cityDropDown,
          );
        } else if (state is JobError) {
          return _showErrorText(state.message);
        } else {
          return const HorizontalGradientStyle(
              widget: Center(child: Icon(Icons.wallpaper)));
        }
      }),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    print('Inside CustomSearchDelegate and search query is $query');

    return _showFilteredResult();
  }

  Widget _showErrorText(String errorMessage) {
    return HorizontalGradientStyle(
        widget: Center(
            child: Text(
      errorMessage,
      textAlign: TextAlign.center,
      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    )));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return (query == '' &&
            indystryMultiSelect.isEmpty &&
            cityDropDown == null &&
            sortAlphabet == false)
        ? HorizontalGradientStyle(
            widget: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(children: [
              const Text(
                'Популярні запити',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    return ListTile(
                      // dense: true,
                      visualDensity: const VisualDensity(vertical: -3),
                      title: Text(
                        _suggestions[index],
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w400),
                      ),
                      onTap: (() => query = _suggestions[index]),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider(
                      thickness: 2,
                    );
                  },
                  itemCount: _suggestions.length,
                ),
              ),
            ]),
          ))
        : _showFilteredResult();
  }
}
