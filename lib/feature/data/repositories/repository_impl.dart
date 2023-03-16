import 'package:dartz/dartz.dart';
import 'package:vacancies/core/error/exception.dart';

import 'package:vacancies/core/error/failure.dart';
import 'package:vacancies/core/platform/network_info.dart';
import 'package:vacancies/feature/data/datasources/local_data_source.dart';
import 'package:vacancies/feature/data/datasources/remote_data_source.dart';
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
  Future<Either<Failure, List<JobEntity>>> getJobs([int? companyId]) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteJob = await remoteDataSource.getJobs(companyId);
        if (companyId == null) localDataSource.jobsToCache(remoteJob);
        return Right(remoteJob);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final locationJob = await localDataSource.getLastJobsFromCache();
        return Right((companyId == null)
            ? locationJob
            : locationJob.where((job) => job.companyId == companyId).toList());
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, int?>> addCompany(CompanyEntity company) async {
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
      return const Right(null);
    }
  }

  @override
  Future<Either<Failure, int?>> addJob(JobEntity job) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteJob = await remoteDataSource.addJob(job);
        localDataSource.jobsToCache(await remoteDataSource.getJobs());
        return Right(remoteJob);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return const Right(null);
    }
  }

  @override
  Future<Either<Failure, bool>> deleteCompany(CompanyEntity company) async {
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
      return const Right(false);
    }
  }

  @override
  Future<Either<Failure, bool>> deleteJob(JobEntity job) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteJob = await remoteDataSource.deleteJob(job);
        localDataSource.jobsToCache(await remoteDataSource.getJobs());
        return Right(remoteJob);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return const Right(false);
    }
  }
}
