part of 'forecast_bloc.dart';

@immutable
sealed class ForecastEvent {}

final class LoadForecastEvent extends ForecastEvent {}
final class SetSelectedDayEvent extends ForecastEvent {
  final ADayData aDayData;
  final ViewData viewData;

  SetSelectedDayEvent( {required this.aDayData,required this.viewData,});
}
