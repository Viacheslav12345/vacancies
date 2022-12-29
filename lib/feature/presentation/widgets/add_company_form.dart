import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vacancies/common/app_colors.dart';
import 'package:vacancies/feature/presentation/bloc/company_list_cubit/company_list_cubit.dart';

class AddCompanyForm extends StatefulWidget {
  const AddCompanyForm({Key? key}) : super(key: key);

  @override
  State<AddCompanyForm> createState() => _AddCompanyFormState();
}

class _AddCompanyFormState extends State<AddCompanyForm> {
  final _nameCompany = TextEditingController();
  final _industryCompany = TextEditingController();
  final _descriptionCompany = TextEditingController();
  final Map<String, dynamic> companyInfo = {};

  @override
  void dispose() {
    _nameCompany.dispose();
    _industryCompany.dispose();
    _descriptionCompany.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Введіть дані компанії:'),
        centerTitle: true,
      ),
      body: Form(
          child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const SizedBox(height: 50),
          TextFormField(
            controller: _nameCompany,
            decoration: const InputDecoration(labelText: "Назва"),
          ),
          const SizedBox(height: 30),
          TextFormField(
            controller: _industryCompany,
            decoration: const InputDecoration(labelText: "Галузь"),
          ),
          const SizedBox(height: 30),
          TextFormField(
            controller: _descriptionCompany,
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
            color: AppColors.buttonColor,
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
      )),
    );
  }

  void _submitForm() {
    companyInfo.addAll(
      {
        'name': _nameCompany.text,
        'industry': _industryCompany.text,
        'description': _descriptionCompany.text,
      },
    );
    BlocProvider.of<CompanyListCubit>(context, listen: false)
        .addCompany(companyInfo);
  }
}
