import 'package:dartz/dartz.dart';
import 'package:vacancies/core/error/failure.dart';

abstract class UseCase<Type> {
  Future<Either<Failure, Type>> call();
}
