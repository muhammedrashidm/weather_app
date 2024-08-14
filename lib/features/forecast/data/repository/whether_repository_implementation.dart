import 'package:my_weather/features/forecast/data/data_sources/remote_weather_data_source.dart';
import 'package:my_weather/features/forecast/data/models/forecast.dart';
import 'package:my_weather/features/forecast/domain/entities/forecast.dart';
import 'package:my_weather/features/forecast/domain/entities/geocode.dart';
import 'package:my_weather/features/forecast/domain/repository/i_repo.dart';
import 'package:my_weather/utils/data/typedef.dart';

class WeatherRepositoryImplementation extends IWhetherForecastRepository {
  final RemoteWeatherDataSource _remoteWeatherDataSource;

  WeatherRepositoryImplementation(
      {required RemoteWeatherDataSource remoteWeatherDataSource})
      : _remoteWeatherDataSource = remoteWeatherDataSource;
  @override
  ResultFuture<ForecastModel> getWhetherData(
      {required String lat, required String lon}) {
    return _remoteWeatherDataSource.getWhetherData(lat: lat, lon: lon);
  }

  @override
  ResultFuture<GeoCode> getGeoCodeData({required String lat, required String lon}) {
    return _remoteWeatherDataSource.getGeoCodeData(lat: lat, lon: lon);
  }
}
