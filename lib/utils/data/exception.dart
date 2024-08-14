import 'package:equatable/equatable.dart';

class Failure extends Equatable implements Exception {
  final String cause;
  const Failure({required this.cause});

  @override
  List<Object?> get props => [];
}

class ApiFailure extends Failure {
  const ApiFailure({required super.cause, required this.responseCode});
  final int responseCode;
}
