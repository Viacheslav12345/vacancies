// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:vacancies/common/app_colors.dart';
import 'package:vacancies/feature/presentation/bloc/job_list_cubit/job_list_cubit.dart';

class AddJobForm extends StatefulWidget {
  int companyId;
  AddJobForm({Key? key, required this.companyId}) : super(key: key);

  @override
  State<AddJobForm> createState() => _AddJobFormState();
}

class _AddJobFormState extends State<AddJobForm> {
  final _nameJob = TextEditingController();
  final _cityJob = TextEditingController();
  final _descriptionJob = TextEditingController();
  final Map<String, dynamic> jobInfo = {};

  @override
  void dispose() {
    _nameJob.dispose();
    _cityJob.dispose();
    _descriptionJob.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Введіть дані про вакансію:'),
        centerTitle: true,
      ),
      body: Form(
          child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const SizedBox(height: 50),
          TextFormField(
            controller: _nameJob,
            decoration: const InputDecoration(labelText: "Назва"),
          ),
          const SizedBox(height: 30),
          TextFormField(
            controller: _cityJob,
            decoration: const InputDecoration(labelText: "Місто"),
          ),
          const SizedBox(height: 30),
          TextFormField(
            controller: _descriptionJob,
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
    jobInfo.addAll(
      {
        'companyId': widget.companyId,
        'title': _nameJob.text,
        'city': _cityJob.text,
        'description': _descriptionJob.text,
      },
    );
    BlocProvider.of<JobListCubit>(context, listen: false).addJob(jobInfo);
  }
}
