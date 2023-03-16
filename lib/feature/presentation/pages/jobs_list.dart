import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vacancies/feature/domain/entities/job_entity.dart';
import 'package:vacancies/feature/presentation/bloc/job_list_cubit/job_list_cubit.dart';
import 'package:vacancies/feature/presentation/bloc/job_list_cubit/job_list_state.dart';
import 'package:vacancies/feature/presentation/widgets/job_card_widget.dart';

class JobsList extends StatelessWidget {
  final int? companyId;
  const JobsList(this.companyId, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<JobListCubit, JobState>(builder: (context, state) {
      List<JobEntity> jobs = [];

      if (state is JobsLoading) {
        return _loadingindicator();
      } else if (state is JobsLoaded) {
        (companyId == null)
            ? jobs = state.jobsList
            : jobs = state.jobsList
                .where((element) => element.companyId == companyId)
                .toList();
      } else if (state is JobsSearching) {
        (companyId == null)
            ? jobs = state.alljobs
            : jobs = state.alljobs
                .where((element) => element.companyId == companyId)
                .toList();
      } else if (state is JobError) {
        return Center(
          child: Text(
            'Не можливо відобразити список:\n ${state.message}',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18,
              color: Color.fromARGB(255, 237, 129, 129),
            ),
          ),
        );
      }

      return ListView.separated(
        shrinkWrap: true,
        itemBuilder: ((context, index) {
          return JobCard(job: jobs[index]);
        }),
        separatorBuilder: (context, index) {
          return Divider(
            color: Colors.grey[400],
          );
        },
        itemCount: jobs.length,
      );
    });
  }

  Widget _loadingindicator() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
