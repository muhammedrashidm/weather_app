import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:my_weather/features/forecast/domain/entities/forecast.dart';
import 'package:my_weather/utils/extensions.dart';

class ViewData {
  String cityName;
  final List<ADayData> days;
  final String timeZone;
  ViewData(
      {required this.timeZone, required this.days, required this.cityName});
}

class ADayData extends Equatable{
  final int weatherCode;
  final DateTime date;
  final DateTime sunrise;
  final DateTime sunset;
  final double min;
  final double max;
  final List<AHourData> hours;
  ADayData(
      {required this.hours,
      required this.date,
      required this.sunrise,
      required this.sunset,
      required this.weatherCode,
      required this.min,
      required this.max});

  @override
  // TODO: implement props
  List<Object?> get props => [date];
}

class AHourData extends Equatable{
  final DateTime time;
  final double temp;

  AHourData({required this.time, required this.temp});

  @override
  // TODO: implement props
  List<Object?> get props => [time];
}

extension ToViewData on Forecast {
  ViewData toViewData() {
    final List<ADayData> days = [];
    for (var (index, elementD) in daily!.time!.indexed) {
      final List<AHourData> hours = [];
      for (var (indexH, elementH) in hourly!.time!.indexed) {
        if (elementH.isSameDate(elementD)) {
          hours.add(
              AHourData(time: elementH, temp: hourly!.temperature2M![indexH]));
        }
      }
      days.add(ADayData(
          hours: hours,
          date: elementD,
          sunrise: daily!.sunrise![index],
          sunset: daily!.sunset![index],
          min: daily!.temperature2MMin![index],
          max: daily!.temperature2MMax![index],
          weatherCode: daily!.weatherCode![index]));
    }
    return ViewData(timeZone: timezone ?? '', days: days, cityName: 'cityName');
  }
}
