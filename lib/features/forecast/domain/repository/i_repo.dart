import 'package:my_weather/features/forecast/domain/entities/forecast.dart';
import 'package:my_weather/features/forecast/domain/entities/geocode.dart';
import 'package:my_weather/utils/data/typedef.dart';

abstract class IWhetherForecastRepository {
  ResultFuture<Forecast> getWhetherData({
    required String lat,
    required String lon,
  }); ResultFuture<GeoCode> getGeoCodeData({
    required String lat,
    required String lon,
  });

}
