import 'package:dartz/dartz.dart';

import 'failures/failure.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams {
  @override
  List<Object> get props => [];
}
