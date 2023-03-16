import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vacancies/common/app_colors.dart';
import 'package:vacancies/feature/presentation/bloc/company_list_cubit/company_list_cubit.dart';
import 'package:vacancies/feature/presentation/bloc/job_list_cubit/job_list_cubit.dart';
import 'package:vacancies/feature/presentation/pages/home_screen.dart';
import 'package:vacancies/locator_service.dart' as di;
import 'package:vacancies/locator_service.dart';

import 'feature/presentation/pages/splash_screen.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<CompanyListCubit>(
            lazy: false,
            create: (context) => sl<CompanyListCubit>()..loadCompany(),
          ),
          BlocProvider<JobListCubit>(
            lazy: false,
            create: (context) => sl<JobListCubit>()..loadJob(),
          ),
        ],
        child: MaterialApp(
          navigatorKey: navigatorKey,
          theme: ThemeData.dark().copyWith(
            bottomSheetTheme: const BottomSheetThemeData(
              // backgroundColor: Color.fromARGB(255, 48, 50, 54),
              backgroundColor: AppColors.mainBackground,
              elevation: 18,
              clipBehavior: Clip.antiAlias,
            ),
            dialogBackgroundColor: AppColors.mainBackground,
            canvasColor: AppColors.mainBackground,
            chipTheme:
                const ChipThemeData(backgroundColor: AppColors.cellBackground),
            textSelectionTheme: const TextSelectionThemeData(
                selectionColor: Colors.grey,
                cursorColor: Colors.grey,
                selectionHandleColor: Colors.grey),
            appBarTheme: const AppBarTheme(
                backgroundColor: AppColors.mainBackground,
                shadowColor: AppColors.mainBackground),
            inputDecorationTheme: const InputDecorationTheme(
              iconColor: AppColors.greyColor,
              labelStyle: TextStyle(color: AppColors.greyColor),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  style: BorderStyle.solid,
                  color: Colors.white,
                ),
              ),
            ),
            progressIndicatorTheme:
                const ProgressIndicatorThemeData(color: AppColors.jobColor),
            primaryColorDark: AppColors.jobColor,
            backgroundColor: AppColors.mainBackground,
            scaffoldBackgroundColor: AppColors.mainBackground,
          ),
          routes: {
            '/splashScreen': (context) => const SplashScreen(),
            '/homePage': (context) => const HomePage(),
          },
          home: const SplashScreen(),
          // home: const HomePage(),
        ));
  }
}
