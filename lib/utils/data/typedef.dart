import 'package:dartz/dartz.dart';
import 'package:my_weather/utils/data/exception.dart';

typedef ResultFuture<T> = Future<Either<Failure, T>>;
typedef VoidFuture = Either<Failure, void>;

typedef MapFunction<T> = T Function(Map<String, dynamic> input);
