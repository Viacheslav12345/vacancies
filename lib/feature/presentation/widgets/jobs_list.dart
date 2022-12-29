import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vacancies/feature/domain/entities/job_entity.dart';
import 'package:vacancies/feature/presentation/bloc/job_list_cubit/job_list_cubit.dart';
import 'package:vacancies/feature/presentation/bloc/job_list_cubit/job_list_state.dart';
import 'package:vacancies/feature/presentation/widgets/job_card_widget.dart';

class JobsList extends StatelessWidget {
  const JobsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<JobListCubit, JobState>(builder: (context, state) {
      List<JobEntity> jobs = [];

      if (state is JobLoading) {
        return _loadingindicator();
      } else if (state is JobLoaded) {
        jobs = state.jobsList;
      }
      return ListView.separated(
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
