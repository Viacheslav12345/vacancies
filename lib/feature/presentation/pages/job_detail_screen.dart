import 'package:flutter/material.dart';
import 'package:vacancies/common/app_colors.dart';
import 'package:vacancies/feature/domain/entities/job_entity.dart';

class JobDetailPage extends StatelessWidget {
  final JobEntity job;
  const JobDetailPage({Key? key, required this.job}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(job.title),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
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
                    Text(
                      '${job.companyId}',
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
                      job.description,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        color: Color(0xFFBDBDBD),
                        fontSize: 22,
                      ),
                      overflow: TextOverflow.ellipsis,
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
                        color: AppColors.buttonColor,
                        fontSize: 25,
                      ),
                    ),
                  ]),
                ],
              ),
            ],
          ),
        ));
  }
}
