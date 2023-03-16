import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vacancies/common/horizontal_gradient_style.dart';
import 'package:vacancies/common/app_colors.dart';
import 'package:vacancies/feature/data/models/company_model.dart';
import 'package:vacancies/feature/presentation/bloc/company_list_cubit/company_list_cubit.dart';
import 'package:vacancies/feature/presentation/widgets/show_dialog.dart';

class AddCompanyForm extends StatefulWidget {
  const AddCompanyForm({Key? key}) : super(key: key);

  @override
  State<AddCompanyForm> createState() => _AddCompanyFormState();
}

class _AddCompanyFormState extends State<AddCompanyForm> {
  final _nameCompany = TextEditingController();
  final _industryCompany = TextEditingController();
  final _descriptionCompany = TextEditingController();
  final _nameFocus = FocusNode();
  final _industryFocus = FocusNode();
  final _descriptionFocus = FocusNode();

  @override
  void dispose() {
    _nameCompany.dispose();
    _industryCompany.dispose();
    _descriptionCompany.dispose();
    _nameFocus.dispose();
    _industryFocus.dispose();
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
          title: const Text('Введіть дані компанії:'),
          centerTitle: true,
          flexibleSpace: const HorizontalGradientStyle(),
        ),
        body: (loading == true)
            ? const HorizontalGradientStyle(
                widget: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : HorizontalGradientStyle(
                widget: ListView(
                  padding: const EdgeInsets.all(20),
                  children: [
                    const SizedBox(height: 50),
                    TextFormField(
                      focusNode: _nameFocus,
                      autofocus: true,
                      onFieldSubmitted: (_) {
                        _fieldFocusChange(context, _nameFocus, _industryFocus);
                      },
                      controller: _nameCompany,
                      decoration: const InputDecoration(labelText: "Назва"),
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      focusNode: _industryFocus,
                      onFieldSubmitted: (_) {
                        _fieldFocusChange(
                            context, _industryFocus, _descriptionFocus);
                      },
                      controller: _industryCompany,
                      decoration: const InputDecoration(labelText: "Галузь"),
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      focusNode: _descriptionFocus,
                      controller: _descriptionCompany,
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
                      color: AppColors.companyColor,
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
                ),
              ),
      ),
    );
  }

  void _submitForm() async {
    loading = true;
    setState(() {});
    final newCompany = CompanyModel(
      id: null,
      name: _nameCompany.text,
      industry: _industryCompany.text,
      description: _descriptionCompany.text,
    );

    bool response = false;
    int? responseInt =
        await BlocProvider.of<CompanyListCubit>(context, listen: false)
            .addCompany(newCompany);

    (responseInt != null) ? response = true : response = false;

    showOkDialog(
      countPop: 2,
      response: response,
      title: 'Додавання компанії',
      content1: 'Компанію ${_nameCompany.text.toUpperCase()} додано.',
      content2:
          "Компанію ${_nameCompany.text.toUpperCase()} не додано.\n Не має зв'язку із сервером!",
    );
  }
}
