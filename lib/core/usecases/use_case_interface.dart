import 'dart:async';

import 'package:equatable/equatable.dart';

abstract class IUseCase<Type, Params> {
  FutureOr<Type> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}
