import 'package:get_it/get_it.dart';
import 'package:my_weather/features/forecast/data/data_sources/remote_weather_data_source.dart';
import 'package:my_weather/features/forecast/data/repository/whether_repository_implementation.dart';
import 'package:my_weather/features/forecast/domain/repository/i_repo.dart';
import 'package:my_weather/utils/data/dio.dart';

class ServiceLocator {
  static GetIt getIt = GetIt.instance;

  static Future<void> setUpDep() async {
    getIt.registerLazySingleton(() => RemoteWeatherDataSource(
        weatherApi: ApiService.weather(), geoCodeApi: ApiService.geoCoder()));

    getIt.registerLazySingleton(() => WeatherRepositoryImplementation(
        remoteWeatherDataSource: getIt<RemoteWeatherDataSource>()));
  }
}
