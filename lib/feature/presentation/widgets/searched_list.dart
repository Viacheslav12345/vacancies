// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

import 'package:vacancies/common/app_colors.dart';
import 'package:vacancies/common/horizontal_gradient_style.dart';
import 'package:vacancies/common/vertical_gradient_style.dart';
import 'package:vacancies/feature/domain/entities/job_entity.dart';
import 'package:vacancies/feature/presentation/bloc/company_list_cubit/company_list_cubit.dart';
import 'package:vacancies/feature/presentation/bloc/job_list_cubit/job_list_cubit.dart';
import 'package:vacancies/feature/presentation/bloc/job_list_cubit/job_list_state.dart';
import 'package:vacancies/feature/presentation/widgets/check_filter_condition.dart';
import 'package:vacancies/feature/presentation/widgets/job_card_widget.dart';

class SearchedList extends StatelessWidget {
  final List<JobEntity> sortJobs;
  final List<JobEntity> allJobs;
  final List<String> indystryMultiSelect;
  final String? cityDropDown;
  final String query;
  final bool sortAlphabet;

  const SearchedList({
    Key? key,
    required this.sortJobs,
    required this.allJobs,
    required this.indystryMultiSelect,
    this.cityDropDown,
    required this.query,
    required this.sortAlphabet,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final jobProvider = BlocProvider.of<JobListCubit>(context);
    final companyIndustryProvider =
        BlocProvider.of<CompanyListCubit>(context).companyIndustry();
    List<String> indystryMultiSelect = [];
    String? cityDropDown;
    bool sortAlphabet = false;

    List<DropdownMenuItem<String>>? cityDropDownList = [];

    cityDropDownList.add(const DropdownMenuItem(
      value: "clearCity",
      child: Text(
        '- скинути -',
        style: TextStyle(fontSize: 20, color: AppColors.companyColor),
      ),
    ));

    cityDropDownList.addAll(jobProvider
        .cityJobs()
        .map((city) => DropdownMenuItem(
              value: city,
              child: Text(
                city,
                // style: TextStyle(fontSize: 14),
              ),
            ))
        .toList());

// !!!!!!!
    var currentState = jobProvider.state;
    if (currentState is JobsSearching) {
      indystryMultiSelect = currentState.indystryMultiSelect;
      cityDropDown = currentState.cityDropDown;
      sortAlphabet = currentState.sortAlphabet;
    }

    return Column(
      children: [
        Text(
          'Знайдено ${sortJobs.length} вакансій.',
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsetsDirectional.only(start: 10, end: 10),
            child: Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              child: VerticalGradientStyle(
                widget: ListView.builder(
                  itemCount: sortJobs.isNotEmpty ? sortJobs.length : 0,
                  itemBuilder: (context, index) {
                    JobEntity result = sortJobs[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: JobCard(job: result),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: SizedBox(
            height: 30,
            width: 200,
            child: CupertinoButton(
              padding: const EdgeInsets.symmetric(vertical: 5),
              color: AppColors.jobColor,
              child: Icon(
                Icons.list,
                color: AppColors.mainBackground,
                shadows: [
                  Shadow(
                      color: Colors.grey,
                      offset: Offset.fromDirection(0.2),
                      blurRadius: 0.3),
                ],
              ),
              onPressed: () {
                showBottomSheet(
                  context: context,
                  shape: const RoundedRectangleBorder(
                      // side: BorderSide(color: AppColors.greyColor),
                      borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  )),
                  constraints: BoxConstraints.expand(
                    height: MediaQuery.of(context).size.height / 3.5,
                    width: MediaQuery.of(context).size.width,
                  ),
                  enableDrag: true,
                  elevation: 15,
                  builder: (context) {
                    return StatefulBuilder(
                        builder: (BuildContext context, StateSetter mystate) {
                      int countCondition = indystryMultiSelect.length +
                          ((cityDropDown != null) ? 1 : 0) +
                          ((sortAlphabet != false) ? 1 : 0);

                      checkCondition(allJobs, indystryMultiSelect, cityDropDown,
                          query, sortAlphabet, context);

                      return HorizontalGradientStyle(
                        widget: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(children: [
                            //---1-Row--Result of Search-------------------------------------------------------
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    (countCondition == 1)
                                        ? 'Вибрана 1 умова'
                                        : 'Вибрано $countCondition ${(countCondition == 2 || countCondition == 3 || countCondition == 4) ? ' умови' : ' умов'}',
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      color: AppColors.jobColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  TextButton(
                                    style: TextButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                      minimumSize: Size.zero,
                                      tapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                    ),
                                    onPressed: () => mystate(() {
                                      indystryMultiSelect.clear();
                                      cityDropDown = null;
                                      sortAlphabet = false;

                                      Navigator.pop(context);
                                    }),
                                    child: const Text(
                                      'Скинути умови',
                                      style: TextStyle(
                                        color: AppColors.companyColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const Divider(height: 3, color: Colors.white),
                            const SizedBox(
                              height: 15,
                            ),
                            //----2-Row----Sort by Name------------------------------------------------
                            InkWell(
                              borderRadius: BorderRadius.circular(10),
                              onTap: () {
                                mystate(() {
                                  (sortAlphabet == true)
                                      ? sortAlphabet = false
                                      : sortAlphabet = true;
                                });
                              },
                              child: Container(
                                padding: const EdgeInsetsDirectional.all(10),
                                decoration: BoxDecoration(
                                  color: (sortAlphabet == true)
                                      ? Colors.black12
                                      : null,
                                  border: Border.all(
                                    color: (sortAlphabet == false)
                                        ? Colors.grey
                                        : Colors.white,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    (sortAlphabet == false)
                                        ? const Text(
                                            'Сортувати за назвою вакансії',
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 17,
                                                fontWeight: FontWeight.w400),
                                          )
                                        : const Text(
                                            'Відсортовано за назвою вакансії',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 17,
                                                fontWeight: FontWeight.w400),
                                          ),
                                    const SizedBox(width: 10),
                                    Icon(
                                      Icons.sort_by_alpha,
                                      color: (sortAlphabet == false)
                                          ? Colors.grey
                                          : Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            //---3-Row-----Search by Industry And City----------------------------------------------------------
                            Expanded(
                              child: Row(children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 4.0),
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.45,
                                    child: MultiSelectDialogField(
                                      initialValue: indystryMultiSelect,
                                      searchHint: 'По категоріям',
                                      chipDisplay:
                                          MultiSelectChipDisplay.none(),
                                      // searchable: true,
                                      buttonText: const Text(
                                        'Категорії',
                                        style: TextStyle(
                                            color: AppColors.companyColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      buttonIcon: const Icon(
                                        Icons.arrow_drop_up_outlined,
                                        size: 23,
                                      ),
                                      barrierColor: Colors.black38,
                                      title: const Text(
                                        'Категорії',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      decoration: const BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: AppColors.jobColor))),
                                      itemsTextStyle: const TextStyle(
                                          fontSize: 16,
                                          color: AppColors.greyColor),
                                      selectedItemsTextStyle: const TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                      selectedColor: AppColors.companyColor,
                                      checkColor: AppColors.mainBackground,
                                      unselectedColor: AppColors.greyColor,
                                      items: companyIndustryProvider
                                          .map((industry) => MultiSelectItem(
                                              industry, industry))
                                          .toList(),
                                      onConfirm: (values) {
                                        mystate(
                                          () {
                                            indystryMultiSelect = values.cast();
                                          },
                                        );
                                      },
                                      onSelectionChanged: (values) {
                                        mystate(
                                          () {
                                            indystryMultiSelect.clear();
                                            indystryMultiSelect
                                                .addAll(values.cast());
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 17.0),
                                    child: DropdownButton(
                                      hint: const Text(
                                        'Місто',
                                        style: TextStyle(
                                            height: -0.25,
                                            color: AppColors.jobColor),
                                        textAlign: TextAlign.end,
                                      ),
                                      value: null,
                                      items: cityDropDownList,
                                      onChanged: ((value) {
                                        mystate(() {
                                          (value == 'clearCity')
                                              ? cityDropDown = null
                                              : cityDropDown = value;
                                        });
                                      }),
                                      isExpanded: true,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                      icon: const Padding(
                                        padding: EdgeInsets.only(bottom: 20.0),
                                        child: Icon(
                                          Icons.arrow_drop_up_outlined,
                                          color: Colors.white,
                                          size: 23,
                                        ),
                                      ),
                                      underline: Container(
                                          height: 1,
                                          color: AppColors.companyColor),
                                      elevation: 16,
                                      alignment:
                                          AlignmentDirectional.centerStart,
                                    ),
                                  ),
                                ),
                              ]),
                            ),
                            //------4-Row-----Current result of Search by Industry and City-------------------------
                            Expanded(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.45,
                                    child: SingleChildScrollView(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: indystryMultiSelect
                                              .map((industry) => Text(
                                                    industry,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ))
                                              .toList(),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            cityDropDown ?? '',
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ]),
                                  ),
                                ],
                              ),
                            ),
//----------------------------------------------------------
                          ]),
                        ),
                      );
                    });
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
