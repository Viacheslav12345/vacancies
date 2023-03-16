import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:vacancies/common/app_colors.dart';
import 'package:vacancies/common/horizontal_gradient_style.dart';
import 'package:vacancies/feature/domain/entities/company_entity.dart';
import 'package:vacancies/feature/presentation/bloc/company_list_cubit/company_list_cubit.dart';
import 'package:vacancies/feature/presentation/bloc/job_list_cubit/job_list_cubit.dart';
import 'package:vacancies/feature/presentation/bloc/job_list_cubit/job_list_state.dart';
import 'package:vacancies/feature/presentation/pages/company_detail_screen.dart';
import 'package:vacancies/feature/presentation/widgets/show_dialog.dart';

import '../../../main.dart';

class CompanyCard extends StatelessWidget {
  final CompanyEntity company;

  const CompanyCard({
    Key? key,
    required this.company,
  }) : super(key: key);

  void deleteAllJobsCurrentCompany() async {
    var context = navigatorKey.currentContext!;
    bool statusDeleteCompany;
    final jobBlocProvider = BlocProvider.of<JobListCubit>(context);
    final stateBlocProvider = jobBlocProvider.state;

    if (stateBlocProvider is JobsLoaded) {
      final jobsList = stateBlocProvider.jobsList;

      for (var job in jobsList) {
        if (job.companyId == company.id) {
          jobBlocProvider.deleteJob(job);
        }
      }
    }
    statusDeleteCompany =
        await BlocProvider.of<CompanyListCubit>(context).deleteCompany(company);
    showOkDialog(
        countPop: 1,
        response: statusDeleteCompany,
        title: 'Видалення компанії',
        content1: 'Компанію ${company.name} видалено.',
        content2:
            "Компанію ${company.name} зараз не можливо видалити.\n Не має зв'язку з сервером!");
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: const ValueKey(0),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        dismissible: DismissiblePane(onDismissed: () {
          deleteAllJobsCurrentCompany();
        }),
        children: [
          SlidableAction(
            onPressed: (_) {
              deleteAllJobsCurrentCompany();
            },
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CompanyDetailPage(company: company)));
          },
          child: HorizontalGradientStyle(
              widget: Column(
            children: [
              const SizedBox(height: 10),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                alignment: Alignment.centerLeft,
                child: Text(
                  company.name,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                alignment: Alignment.centerLeft,
                child: Text(
                  company.description,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    color: Color(0xFFBDBDBD),
                    fontSize: 15,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                alignment: Alignment.centerRight,
                child: Text(
                  company.industry,
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 244, 171, 171),
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          )),
        ),
      ),
    );
  }
}
