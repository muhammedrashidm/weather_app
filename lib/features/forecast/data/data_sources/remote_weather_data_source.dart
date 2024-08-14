import 'package:my_weather/features/forecast/data/fake_ds.dart';
import 'package:my_weather/features/forecast/data/models/forecast.dart';
import 'package:my_weather/features/forecast/data/models/geocode.dart';
import 'package:my_weather/features/forecast/domain/entities/forecast.dart';
import 'package:my_weather/features/forecast/domain/repository/i_repo.dart';
import 'package:my_weather/utils/data/dio.dart';
import 'package:my_weather/utils/data/typedef.dart';

abstract class IRemoteWeatherDataSource {
  ResultFuture<ForecastModel> getWhetherData({
    required String lat,
    required String lon,
  });
  ResultFuture<GeoCodeModel> getGeoCodeData({
    required String lat,
    required String lon,
  });
}

class RemoteWeatherDataSource extends IRemoteWeatherDataSource {
  final ApiService _weatherApi;
  final ApiService _geoCodeApi;

  RemoteWeatherDataSource(
      {required ApiService weatherApi, required ApiService geoCodeApi})
      : _weatherApi = weatherApi,
        _geoCodeApi = geoCodeApi;

  @override
  ResultFuture<ForecastModel> getWhetherData(
      {required String lat, required String lon}) async {
    return _weatherApi.get('/forecast', queryParams: {
      "latitude": lat,
      "longitude": lon,
      ...weatherBaseQueryParams
    }, mapFunction: (data) {
      return ForecastModel.fromJson(fakeData);
    });
  }

  @override
  ResultFuture<GeoCodeModel> getGeoCodeData(
      {required String lat, required String lon}) {
    return _geoCodeApi.get('/reverse',
        queryParams: {"lat": lat, "lon": lon, ...geoCodeBaseQueryParams},
        mapFunction: (data) {
      return GeoCodeModel.fromJson(data);
    });
  }
}
