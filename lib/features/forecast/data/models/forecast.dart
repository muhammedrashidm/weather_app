// To parse this JSON data, do
//
//     final forecastModel = forecastModelFromJson(jsonString);
import 'dart:convert';

import 'package:my_weather/features/forecast/domain/entities/forecast.dart';

ForecastModel forecastModelFromJson(String str) =>
    ForecastModel.fromJson(json.decode(str));

String forecastModelToJson(ForecastModel data) => json.encode(data.toJson());

class ForecastModel extends Forecast {
  final double? latitude;
  final double? longitude;
  final double? generationtimeMs;
  final int? utcOffsetSeconds;
  final String? timezone;
  final String? timezoneAbbreviation;
  final double? elevation;
  final HourlyUnitsModel? hourlyUnits;
  final HourlyModel? hourly;
  final DailyUnitsModel? dailyUnits;
  final DailyModel? daily;

  ForecastModel({
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
  }) : super(
            latitude: latitude ?? 0.0,
            longitude:longitude?? 0.0,
            generationtimeMs: generationtimeMs??0.0,
            utcOffsetSeconds:utcOffsetSeconds?? 0,
            timezone: timezone ?? '',
            timezoneAbbreviation: timezoneAbbreviation ?? '',
            elevation:elevation ?? 0,
            hourlyUnits: hourlyUnits,
            hourly: hourly,
            dailyUnits: dailyUnits,
            daily: daily);

  factory ForecastModel.fromJson(Map<String, dynamic> json) => ForecastModel(
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
        generationtimeMs: json["generationtime_ms"]?.toDouble(),
        utcOffsetSeconds: json["utc_offset_seconds"],
        timezone: json["timezone"],
        timezoneAbbreviation: json["timezone_abbreviation"],
        elevation: json["elevation"],
        hourlyUnits: json["hourly_units"] == null
            ? null
            : HourlyUnitsModel.fromJson(json["hourly_units"]),
        hourly: json["hourly"] == null
            ? null
            : HourlyModel.fromJson(json["hourly"]),
        dailyUnits: json["daily_units"] == null
            ? null
            : DailyUnitsModel.fromJson(json["daily_units"]),
        daily:
            json["daily"] == null ? null : DailyModel.fromJson(json["daily"]),
      );

  Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
        "generationtime_ms": generationtimeMs,
        "utc_offset_seconds": utcOffsetSeconds,
        "timezone": timezone,
        "timezone_abbreviation": timezoneAbbreviation,
        "elevation": elevation,
        "hourly_units": hourlyUnits?.toJson(),
        "hourly": hourly?.toJson(),
        "daily_units": dailyUnits?.toJson(),
        "daily": daily?.toJson(),
      };
}

class DailyModel extends Daily {
  final List<DateTime>? time;
  final List<int>? weatherCode;
  final List<double>? temperature2MMax;
  final List<double>? temperature2MMin;
  final List<DateTime>? sunrise;
  final List<DateTime>? sunset;

  DailyModel({
    this.time,
    this.weatherCode,
    this.temperature2MMax,
    this.temperature2MMin,
    this.sunrise,
    this.sunset,
  }) : super(
            time: time ?? [],
            weatherCode: weatherCode ?? [],
            temperature2MMax: temperature2MMax ?? [],
            temperature2MMin: temperature2MMin ?? [],
            sunrise: sunrise,
            sunset: sunset);

  factory DailyModel.fromJson(Map<String, dynamic> json) => DailyModel(
        time: json["time"] == null
            ? []
            : List<DateTime>.from(json["time"]!.map((x) => DateTime.tryParse(x))),
        weatherCode: json["weather_code"] == null
            ? []
            : List<int>.from(json["weather_code"]!.map((x) => x)),
        temperature2MMax: json["temperature_2m_max"] == null
            ? []
            : List<double>.from(
                json["temperature_2m_max"]!.map((x) => x?.toDouble())),
        temperature2MMin: json["temperature_2m_min"] == null
            ? []
            : List<double>.from(
                json["temperature_2m_min"]!.map((x) => x?.toDouble())),
        sunrise: json["sunrise"] == null
            ? []
            : List<DateTime>.from(json["sunrise"]!.map((x) => DateTime.tryParse(x))),
        sunset: json["sunset"] == null
            ? []
            : List<DateTime>.from(json["sunset"]!.map((x) => DateTime.tryParse(x))),
      );

  Map<String, dynamic> toJson() => {
        "time": time == null
            ? []
            : List<dynamic>.from(time!.map((x) =>
                "${x.year.toString().padLeft(4, '0')}-${x.month.toString().padLeft(2, '0')}-${x.day.toString().padLeft(2, '0')}")),
        "weather_code": weatherCode == null
            ? []
            : List<dynamic>.from(weatherCode!.map((x) => x)),
        "temperature_2m_max": temperature2MMax == null
            ? []
            : List<dynamic>.from(temperature2MMax!.map((x) => x)),
        "temperature_2m_min": temperature2MMin == null
            ? []
            : List<dynamic>.from(temperature2MMin!.map((x) => x)),
        "sunrise":
            sunrise == null ? [] : List<dynamic>.from(sunrise!.map((x) => x)),
        "sunset":
            sunset == null ? [] : List<dynamic>.from(sunset!.map((x) => x)),
      };
}

class DailyUnitsModel extends DailyUnits {
  final String? time;
  final String? weatherCode;
  final String? temperature2MMax;
  final String? temperature2MMin;
  final String? sunrise;
  final String? sunset;

  DailyUnitsModel({
    this.time,
    this.weatherCode,
    this.temperature2MMax,
    this.temperature2MMin,
    this.sunrise,
    this.sunset,
  }) : super(
            time: time??'',
            weatherCode:weatherCode ?? '',
            temperature2MMax:temperature2MMax ?? '',
            temperature2MMin: temperature2MMin ??'',
            sunrise:sunrise?? '',
            sunset: sunset ?? '');

  factory DailyUnitsModel.fromJson(Map<String, dynamic> json) =>
      DailyUnitsModel(
        time: json["time"],
        weatherCode: json["weather_code"],
        temperature2MMax: json["temperature_2m_max"],
        temperature2MMin: json["temperature_2m_min"],
        sunrise: json["sunrise"],
        sunset: json["sunset"],
      );

  Map<String, dynamic> toJson() => {
        "time": time,
        "weather_code": weatherCode,
        "temperature_2m_max": temperature2MMax,
        "temperature_2m_min": temperature2MMin,
        "sunrise": sunrise,
        "sunset": sunset,
      };
}

class HourlyModel extends Hourly {
  final List<DateTime>? time;
  final List<double>? temperature2M;

  HourlyModel({
    this.time,
    this.temperature2M,
  }) : super(time: time ??[], temperature2M: temperature2M ?? []);

  factory HourlyModel.fromJson(Map<String, dynamic> json) => HourlyModel(
        time: json["time"] == null
            ? []
            : List<DateTime>.from(json["time"]!.map((x) => DateTime.tryParse(x))),
        temperature2M: json["temperature_2m"] == null
            ? []
            : List<double>.from(
                json["temperature_2m"]!.map((x) => x?.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "time": time == null ? [] : List<dynamic>.from(time!.map((x) => x)),
        "temperature_2m": temperature2M == null
            ? []
            : List<dynamic>.from(temperature2M!.map((x) => x)),
      };
}

class HourlyUnitsModel extends HourlyUnits {
  final String? time;
  final String? temperature2M;

  HourlyUnitsModel({
    this.time,
    this.temperature2M,
  }) : super(time:time?? '', temperature2M: temperature2M ??'');

  factory HourlyUnitsModel.fromJson(Map<String, dynamic> json) =>
      HourlyUnitsModel(
        time: json["time"],
        temperature2M: json["temperature_2m"],
      );

  Map<String, dynamic> toJson() => {
        "time": time,
        "temperature_2m": temperature2M,
      };
}
