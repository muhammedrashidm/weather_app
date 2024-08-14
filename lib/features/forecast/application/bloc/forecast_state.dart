part of 'forecast_bloc.dart';

@immutable
sealed class ForecastState {}

final class ForecastInitial extends ForecastState {}

final class ForecastLoading extends ForecastState {}

final class ForecastLoaded extends ForecastState {
  final ViewData forecastData;
  final ADayData? selectedDay;
  final AHourData? currentHour;

  ForecastLoaded({required this.forecastData,this.selectedDay,this.currentHour});
}

final class ForecastLoadingError extends ForecastState {
  final String cause;

  ForecastLoadingError({required this.cause});
}

