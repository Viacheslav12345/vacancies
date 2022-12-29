import 'package:dartz/dartz.dart';
import 'package:vacancies/core/error/failure.dart';

abstract class UseCaseParam<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}
