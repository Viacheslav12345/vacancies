// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:vacancies/common/app_colors.dart';
import 'package:vacancies/common/horizontal_gradient_style.dart';
import 'package:vacancies/feature/domain/entities/job_entity.dart';
import 'package:vacancies/feature/presentation/bloc/company_list_cubit/company_list_cubit.dart';
import 'package:vacancies/feature/presentation/bloc/job_list_cubit/job_list_cubit.dart';
import 'package:vacancies/feature/presentation/pages/job_detail_screen.dart';
import 'package:vacancies/feature/presentation/widgets/show_dialog.dart';
import 'package:vacancies/main.dart';

class JobCard extends StatelessWidget {
  final JobEntity job;

  const JobCard({
    Key? key,
    required this.job,
  }) : super(key: key);

  void _deleteCurrentJob() async {
    var context = navigatorKey.currentContext!;
    bool statusDeleteJob =
        await BlocProvider.of<JobListCubit>(context).deleteJob(job);
    showOkDialog(
        countPop: 1,
        response: statusDeleteJob,
        title: 'Видалення вакансії',
        content1: 'Вакансію ${job.title.toUpperCase()} видалено.',
        content2:
            "Вакансію ${job.title.toUpperCase()} зараз не можливо видалити.\n Не має зв'язку з сервером!");
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
        key: const ValueKey(0),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          dismissible: DismissiblePane(onDismissed: () {
            _deleteCurrentJob();
          }),
          children: [
            SlidableAction(
              onPressed: (context) {
                _deleteCurrentJob();
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
                      builder: (context) => JobDetailPage(
                            job: job,
                          )));
            },
            child: HorizontalGradientStyle(
              widget: Column(
                children: [
                  const SizedBox(height: 10),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      job.title,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        fontSize: 20,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      BlocProvider.of<CompanyListCubit>(context)
                              .companyName(job.companyId) ??
                          '',
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        color: AppColors.jobColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      job.description,
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
                      job.city,
                      style: const TextStyle(
                        color: AppColors.jobColor,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ));
  }
}
