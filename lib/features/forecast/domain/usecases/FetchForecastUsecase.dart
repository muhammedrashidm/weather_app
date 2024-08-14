import 'package:my_weather/features/forecast/domain/entities/forecast.dart';
import 'package:my_weather/features/forecast/domain/repository/i_repo.dart';
import 'package:my_weather/utils/data/typedef.dart';
import 'package:my_weather/utils/domain/usecase.dart';

class FetchForecastUseCase
    extends UseCaseWithParams<Forecast, FetchForecastUseCaseInput> {
  final IWhetherForecastRepository _forecastRepository;

  FetchForecastUseCase({required IWhetherForecastRepository forecastRepository})
      : _forecastRepository = forecastRepository;
  @override
  ResultFuture<Forecast> call(params) {
    return _forecastRepository.getWhetherData(lat: params.lat, lon: params.lon);
  }
}

class FetchForecastUseCaseInput {
  final String lat;
  final String lon;

  FetchForecastUseCaseInput({required this.lat, required this.lon});
}
