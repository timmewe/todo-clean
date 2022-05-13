import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_clean/core/error/failures.dart';

abstract class IUseCase<Type, Params> {
  Future<Either<Type, Failure>> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}
