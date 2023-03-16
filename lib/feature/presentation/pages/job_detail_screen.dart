import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vacancies/common/app_colors.dart';
import 'package:vacancies/common/horizontal_gradient_style.dart';
import 'package:vacancies/feature/domain/entities/job_entity.dart';
import 'package:vacancies/feature/presentation/bloc/company_list_cubit/company_list_cubit.dart';

class JobDetailPage extends StatelessWidget {
  final JobEntity job;
  const JobDetailPage({Key? key, required this.job}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(job.title),
        ),
        body: HorizontalGradientStyle(
          widget: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const SizedBox(height: 30),
                Column(children: [
                  const Text(
                    'Вакансія:',
                    style: TextStyle(
                      color: Color.fromARGB(255, 156, 159, 161),
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Text(
                    job.title,
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
                        'Компанія:',
                        style: TextStyle(
                          color: Color.fromARGB(255, 156, 159, 161),
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Flexible(
                        child: Text(
                          BlocProvider.of<CompanyListCubit>(context)
                                  .companyName(job.companyId) ??
                              '',
                          style: const TextStyle(
                            color: AppColors.jobColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
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
                      Expanded(
                        child: Text(
                          job.description,
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
                    Row(children: [
                      const Text(
                        'Місто:',
                        style: TextStyle(
                          color: Color.fromARGB(255, 156, 159, 161),
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Text(
                        job.city,
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                          color: AppColors.jobColor,
                          fontSize: 25,
                        ),
                      ),
                    ]),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
