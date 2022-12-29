import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vacancies/common/app_colors.dart';
import 'package:vacancies/feature/domain/entities/company_entity.dart';
import 'package:vacancies/feature/presentation/bloc/company_jobs_cubit/company_jobs_cubit.dart';
import 'package:vacancies/feature/presentation/widgets/add_job_form.dart';
import 'package:vacancies/feature/presentation/widgets/company_jobs_list.dart';

class CompanyDetailPage extends StatelessWidget {
  final CompanyEntity company;

  const CompanyDetailPage({Key? key, required this.company}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final companyJobsProvider =
        BlocProvider.of<CompanyJobsListCubit>(context, listen: false);
    companyJobsProvider.loadCompanyJob(company.id);

    return Scaffold(
      appBar: AppBar(
        title: Text(company.name),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 30),
            Column(children: [
              const Text(
                'Компанія:',
                style: TextStyle(
                  color: Color.fromARGB(255, 156, 159, 161),
                  fontSize: 15,
                ),
              ),
              const SizedBox(width: 20),
              Text(
                company.name,
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ]),
            const SizedBox(
              height: 20,
              width: 30,
            ),
            Column(
              children: [
                Row(children: [
                  const Text(
                    'Галузь:',
                    style: TextStyle(
                      color: Color.fromARGB(255, 156, 159, 161),
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Text(
                    company.industry,
                    style: const TextStyle(
                      color: AppColors.buttonColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                ]),
                const SizedBox(
                  height: 20,
                  width: 30,
                ),
                Row(children: [
                  const Text(
                    'Опис:',
                    style: TextStyle(
                      color: Color.fromARGB(255, 156, 159, 161),
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Text(
                    company.description,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      color: Color(0xFFBDBDBD),
                      fontSize: 22,
                    ),
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  ),
                ]),
                const SizedBox(
                  height: 20,
                  width: 30,
                ),
                const CompanyJobsList(),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddJobForm(
                        companyId: company.id,
                      )));
        },
        backgroundColor: AppColors.buttonColor,
        tooltip: 'Add',
        child: const Icon(Icons.add),
      ),
    );
  }
}
