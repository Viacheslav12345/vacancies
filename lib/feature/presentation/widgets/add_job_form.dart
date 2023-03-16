// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vacancies/common/horizontal_gradient_style.dart';

import 'package:vacancies/common/app_colors.dart';
import 'package:vacancies/feature/data/models/job_model.dart';
import 'package:vacancies/feature/presentation/bloc/company_list_cubit/company_list_cubit.dart';
import 'package:vacancies/feature/presentation/bloc/company_list_cubit/company_list_state.dart';
import 'package:vacancies/feature/presentation/bloc/job_list_cubit/job_list_cubit.dart';
import 'package:vacancies/feature/presentation/widgets/show_dialog.dart';

class AddJobForm extends StatefulWidget {
  final int? companyId;
  const AddJobForm(
    this.companyId, {
    Key? key,
  }) : super(key: key);

  @override
  State<AddJobForm> createState() => _AddJobFormState();
}

class _AddJobFormState extends State<AddJobForm> {
  final _nameJob = TextEditingController();
  final _cityJob = TextEditingController();
  final _descriptionJob = TextEditingController();
  int? selectedCompanyId;

  final _companyFocus = FocusNode();
  final _nameFocus = FocusNode();
  final _cityFocus = FocusNode();
  final _descriptionFocus = FocusNode();

  @override
  void dispose() {
    _nameJob.dispose();
    _cityJob.dispose();
    _descriptionJob.dispose();
    _companyFocus.dispose();
    _nameFocus.dispose();
    _cityFocus.dispose();
    _descriptionFocus.dispose();

    super.dispose();
  }

  void _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(
            loading == false); // if true allow back else block it
      },
      child: Scaffold(
          appBar: AppBar(
              title: const Text('Введіть дані про вакансію:'),
              centerTitle: true,
              flexibleSpace: const HorizontalGradientStyle()),
          body: (loading == true)
              ? const HorizontalGradientStyle(
                  widget: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : HorizontalGradientStyle(
                  widget: ListView(
                      padding: const EdgeInsets.all(20),
                      children: (widget.companyId == null)
                          ? [
                              BlocBuilder<CompanyListCubit, CompanyState>(
                                  builder: (context, state) {
                                Map<int?, String> companies = {};

                                if (state is CompanyLoaded) {
                                  state.companyList
                                      .map((company) => companies.addEntries(
                                          {company.id: company.name}.entries))
                                      .toList();
                                  selectedCompanyId = companies.keys.firstWhere(
                                      (element) =>
                                          companies[element] ==
                                          companies.values.first);
                                }

                                return Container(
                                  constraints: BoxConstraints(
                                    maxHeight:
                                        MediaQuery.of(context).size.height,
                                  ),
                                  child: DropdownButtonFormField(
                                    focusNode: _companyFocus,
                                    autofocus: true,
                                    style: const TextStyle(
                                        color: AppColors.companyColor,
                                        fontSize: 18),
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      icon: Icon(Icons.business),
                                      labelText: 'Компанія',
                                    ),
                                    value: companies.values.first,
                                    items: companies.values.map((company) {
                                      return DropdownMenuItem(
                                        value: company,
                                        child: Text(company),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      _fieldFocusChange(
                                          context, _companyFocus, _nameFocus);
                                      print(value);
                                      selectedCompanyId = companies.keys
                                          .firstWhere((element) =>
                                              companies[element] == value);
                                    },
                                    validator: (value) {
                                      return (value == null
                                          ? 'Виберіть назву компанії'
                                          : null);
                                    },
                                  ),
                                );
                              }),
                              _textFields(selectedCompanyId),
                            ]
                          : [_textFields(widget.companyId)]),
                )),
    );
  }

  Widget _textFields(int? companyId) {
    return Column(
      children: [
        const SizedBox(height: 50),
        TextFormField(
          focusNode: _nameFocus,
          onFieldSubmitted: (_) {
            _fieldFocusChange(context, _nameFocus, _cityFocus);
          },
          controller: _nameJob,
          decoration: const InputDecoration(labelText: "Назва"),
        ),
        const SizedBox(height: 30),
        TextFormField(
          focusNode: _cityFocus,
          onFieldSubmitted: (_) {
            _fieldFocusChange(context, _cityFocus, _descriptionFocus);
          },
          controller: _cityJob,
          decoration: const InputDecoration(labelText: "Місто"),
        ),
        const SizedBox(height: 30),
        TextFormField(
          focusNode: _descriptionFocus,
          controller: _descriptionJob,
          keyboardType: TextInputType.text,
          decoration: const InputDecoration(
            labelText: "Опис",
            border: OutlineInputBorder(),
          ),
          maxLines: 8,
          inputFormatters: [LengthLimitingTextInputFormatter(500)],
        ),
        const SizedBox(height: 30),
        CupertinoButton(
          onPressed: _submitForm,
          color: AppColors.jobColor,
          child: const Text(
            'Підтвердити',
            style: TextStyle(
              color: AppColors.mainBackground,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        )
      ],
    );
  }

  void _submitForm() async {
    loading = true;
    setState(() {});
    final newJob = JobModel(
      id: null,
      companyId:
          (widget.companyId == null) ? selectedCompanyId : widget.companyId,
      title: _nameJob.text,
      description: _descriptionJob.text,
      city: _cityJob.text,
    );

    bool response = false;
    final jobProvider = BlocProvider.of<JobListCubit>(context, listen: false);

    int? responseInt = await jobProvider.addJob(newJob);

    (responseInt != null) ? response = true : response = false;

    showOkDialog(
      countPop: 2,
      response: response,
      title: 'Додавання вакансії',
      content1: 'Вакансію ${_nameJob.text.toUpperCase()} додано.',
      content2:
          "Вакансію ${_nameJob.text.toUpperCase()} не додано.\n Не має зв'язку із сервером!",
    );
    // Navigator.pop(context);
  }
}
