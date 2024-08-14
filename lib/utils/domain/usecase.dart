import 'package:my_weather/utils/data/typedef.dart';

abstract class UseCaseWithParams<Type,Params>{
  const UseCaseWithParams();
  ResultFuture<Type> call(Params params);
}

abstract class UseCaseWithOutParams<Type>{
  const UseCaseWithOutParams();
  ResultFuture<Type> call();
}