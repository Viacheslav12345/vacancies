import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vacancies/core/platform/network_info.dart';
import 'package:vacancies/feature/data/const.dart';
import 'package:vacancies/feature/data/datasources/local_data_source.dart';
import 'package:vacancies/feature/data/datasources/remote_data_source.dart';
import 'package:vacancies/feature/data/repositories/repository_impl.dart';
import 'package:vacancies/feature/domain/repositories/repository.dart';
import 'package:vacancies/feature/domain/usecases/add_company.dart';
import 'package:vacancies/feature/domain/usecases/add_job.dart';
import 'package:vacancies/feature/domain/usecases/get_all_companies.dart';
import 'package:vacancies/feature/domain/usecases/get_all_jobs.dart';
import 'package:vacancies/feature/domain/usecases/get_company_jobs.dart';
import 'package:vacancies/feature/presentation/bloc/company_list_cubit/company_list_cubit.dart';
import 'package:vacancies/feature/presentation/bloc/job_list_cubit/job_list_cubit.dart';

import 'feature/presentation/bloc/company_jobs_cubit/company_jobs_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //BLoc / Cubit
  sl.registerFactory(
    () => CompanyListCubit(sl(), getAllCompanies: sl()),
  );
  sl.registerFactory(
    () => JobListCubit(sl(), getAllJobs: sl()),
  );
  sl.registerFactory(
    () => CompanyJobsListCubit(getCompanyJobs: sl()),
  );

//UseCases
  sl.registerLazySingleton(
    () => GetAllJobs(sl()),
  );
  sl.registerLazySingleton(
    () => GetAllCompanies(sl()),
  );
  sl.registerLazySingleton(
    () => GetCompanyJobs(sl()),
  );
  sl.registerLazySingleton(
    () => AddCompany(sl()),
  );
  sl.registerLazySingleton(
    () => AddJob(sl()),
  );

//Repository
  sl.registerLazySingleton<Repository>(() => RepositoryImpl(
        localDataSource: sl(),
        remoteDataSource: sl(),
        networkInfo: sl(),
      ));

  sl.registerLazySingleton<RemoteDataSource>(() => RemoteDataSourceImpl(
        client: Dio(BaseOptions(baseUrl: baseUrl)),
      ));

  sl.registerLazySingleton<LocalDataSource>(
    () => LocalDataSourceImpl(sharedPreferences: sl()),
  );

//Core
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(sl()),
  );

//External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(
    () => Dio(),
  );
  sl.registerLazySingleton(
    () => InternetConnectionChecker(),
  );
}
