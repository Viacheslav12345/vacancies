import 'package:dartz/dartz.dart';
import 'package:vacancies/core/error/exception.dart';

import 'package:vacancies/core/error/failure.dart';
import 'package:vacancies/core/platform/network_info.dart';
import 'package:vacancies/feature/data/datasources/local_data_source.dart';
import 'package:vacancies/feature/data/datasources/remote_data_source.dart';
import 'package:vacancies/feature/data/models/company_model.dart';
import 'package:vacancies/feature/data/models/job_model.dart';
import 'package:vacancies/feature/domain/entities/company_entity.dart';
import 'package:vacancies/feature/domain/entities/job_entity.dart';
import 'package:vacancies/feature/domain/repositories/repository.dart';

class RepositoryImpl implements Repository {
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  RepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<CompanyEntity>>> getAllCompanies() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteCompany = await remoteDataSource.getAllCompanies();
        localDataSource.companiesToCache(remoteCompany);
        return Right(remoteCompany);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final locationCompany =
            await localDataSource.getLastCompaniesFromCache();
        return Right(locationCompany);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, List<JobEntity>>> getAllJobs() async {
    return await _getJobs(() {
      return remoteDataSource.getAllJobs();
    });
  }

  @override
  Future<Either<Failure, List<JobEntity>>> getCompanyJobs(int companyId) async {
    return await _getJobs(() {
      return remoteDataSource.getCompanyJobs(companyId);
    });
  }

  Future<Either<Failure, List<JobModel>>> _getJobs(
      Future<List<JobModel>> Function() getJobs) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteJob = await getJobs();
        localDataSource.jobsToCache(remoteJob);
        return Right(remoteJob);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final locationJob = await localDataSource.getLastJobsFromCache();
        return Right(locationJob);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, void>> addCompany(Map<String, dynamic> company) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteCompany = await remoteDataSource.addCompany(company);
        localDataSource
            .companiesToCache(await remoteDataSource.getAllCompanies());
        return Right(remoteCompany);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> addJob(Map<String, dynamic> job) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteJob = await remoteDataSource.addJob(job);
        localDataSource.jobsToCache(await remoteDataSource.getAllJobs());
        return Right(remoteJob);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteCompany(CompanyEntity company) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteCompany = await remoteDataSource.deleteCompany(company);
        localDataSource
            .companiesToCache(await remoteDataSource.getAllCompanies());
        return Right(remoteCompany);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteJob(JobEntity job) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteJob = await remoteDataSource.deleteJob(job);
        localDataSource.jobsToCache(await remoteDataSource.getAllJobs());
        return Right(remoteJob);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }
}
