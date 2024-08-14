import 'package:equatable/equatable.dart';

class Forecast extends Equatable {
  final double? latitude;
  final double? longitude;
  final double? generationtimeMs;
  final int? utcOffsetSeconds;
  final String? timezone;
  final String? timezoneAbbreviation;
  final double? elevation;
  final HourlyUnits? hourlyUnits;
  final Hourly? hourly;
  final DailyUnits? dailyUnits;
  final Daily? daily;

  const Forecast({
    this.latitude,
    this.longitude,
    this.generationtimeMs,
    this.utcOffsetSeconds,
    this.timezone,
    this.timezoneAbbreviation,
    this.elevation,
    this.hourlyUnits,
    this.hourly,
    this.dailyUnits,
    this.daily,
  });

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class Daily extends Equatable {
  final List<DateTime>? time;
  final List<int>? weatherCode;
  final List<double>? temperature2MMax;
  final List<double>? temperature2MMin;
  final List<DateTime>? sunrise;
  final List<DateTime>? sunset;

  Daily({
    this.time,
    this.weatherCode,
    this.temperature2MMax,
    this.temperature2MMin,
    this.sunrise,
    this.sunset,
  });

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class DailyUnits extends Equatable {
  final String? time;
  final String? weatherCode;
  final String? temperature2MMax;
  final String? temperature2MMin;
  final String? sunrise;
  final String? sunset;

  DailyUnits({
    this.time,
    this.weatherCode,
    this.temperature2MMax,
    this.temperature2MMin,
    this.sunrise,
    this.sunset,
  });

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class Hourly extends Equatable {
  final List<DateTime>? time;
  final List<double>? temperature2M;

  Hourly({
    this.time,
    this.temperature2M,
  });

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class HourlyUnits extends Equatable {
  final String? time;
  final String? temperature2M;

  HourlyUnits({
    this.time,
    this.temperature2M,
  });

  @override
  // TODO: implement props
  List<Object> get props => [];
}
