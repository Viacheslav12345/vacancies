import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vacancies/common/app_colors.dart';
import 'package:vacancies/feature/presentation/bloc/company_list_cubit/company_list_cubit.dart';
import 'package:vacancies/feature/presentation/bloc/job_list_cubit/job_list_cubit.dart';
import 'package:vacancies/feature/presentation/bloc/company_jobs_cubit/company_jobs_cubit.dart';
import 'package:vacancies/feature/presentation/pages/home_screen.dart';
import 'package:vacancies/locator_service.dart' as di;
import 'package:vacancies/locator_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<CompanyListCubit>(
            create: (context) => sl<CompanyListCubit>()..loadCompany(),
          ),
          BlocProvider<JobListCubit>(
            create: (context) => sl<JobListCubit>()..loadJob(),
          ),
          BlocProvider<CompanyJobsListCubit>(
            create: (context) => sl<CompanyJobsListCubit>(),
          ),
        ],
        child: MaterialApp(
          theme: ThemeData.dark().copyWith(
            backgroundColor: AppColors.mainBackground,
            scaffoldBackgroundColor: AppColors.mainBackground,
          ),
          home: const HomePage(),
        ));
  }
}
