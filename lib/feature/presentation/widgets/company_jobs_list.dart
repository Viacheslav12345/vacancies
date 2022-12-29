import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vacancies/feature/domain/entities/job_entity.dart';
import 'package:vacancies/feature/presentation/bloc/company_jobs_cubit/company_jobs_cubit.dart';
import 'package:vacancies/feature/presentation/bloc/company_jobs_cubit/company_jobs_state.dart';
import 'package:vacancies/feature/presentation/widgets/job_card_widget.dart';

class CompanyJobsList extends StatelessWidget {
  const CompanyJobsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompanyJobsListCubit, CompanyJobState>(
        builder: (context, state) {
      List<JobEntity> companyJobs = [];

      if (state is CompanyJobLoading) {
        return _loadingindicator();
      } else if (state is CompanyJobLoaded) {
        companyJobs = state.jobsList;
      }
      return ListView.separated(
        shrinkWrap: true,
        itemBuilder: ((context, index) {
          return JobCard(
            job: companyJobs[index],
          );
        }),
        separatorBuilder: (context, index) {
          return Divider(
            color: Colors.grey[400],
          );
        },
        itemCount: (companyJobs.isNotEmpty) ? companyJobs.length : 0,
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
