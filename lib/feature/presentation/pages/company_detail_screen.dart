import 'package:flutter/material.dart';
import 'package:vacancies/common/app_colors.dart';
import 'package:vacancies/common/horizontal_gradient_style.dart';
import 'package:vacancies/common/vertical_gradient_style.dart';
import 'package:vacancies/feature/domain/entities/company_entity.dart';
import 'package:vacancies/feature/presentation/pages/jobs_list.dart';
import 'package:vacancies/feature/presentation/widgets/add_job_form.dart';

class CompanyDetailPage extends StatelessWidget {
  final CompanyEntity company;

  const CompanyDetailPage({Key? key, required this.company}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(company.name),
      ),
      body: VerticalGradientStyle(
        widget: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
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
                      color: AppColors.companyColor,
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
                  Flexible(
                    child: Text(
                      company.description,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        color: Color(0xFFBDBDBD),
                        fontSize: 18,
                      ),
                    ),
                  ),
                ]),
                const SizedBox(
                  height: 20,
                  width: 30,
                ),
                Container(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height,
                  ),
                  child: JobsList(company.id),
                ),
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
                        company.id,
                      )));
        },
        backgroundColor: AppColors.jobColor,
        tooltip: 'Add',
        child: const Icon(Icons.add),
      ),
    );
  }
}
