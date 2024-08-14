import 'package:my_weather/features/forecast/domain/entities/geocode.dart';
import 'package:my_weather/features/forecast/domain/repository/i_repo.dart';
import 'package:my_weather/utils/data/typedef.dart';
import 'package:my_weather/utils/domain/usecase.dart';

class GetGeoCodeUseCase extends UseCaseWithParams<GeoCode,GetGeoCodeUseCaseInput>{
  final IWhetherForecastRepository _forecastRepository;

  GetGeoCodeUseCase({required IWhetherForecastRepository forecastRepository}) : _forecastRepository = forecastRepository;

  @override
  ResultFuture<GeoCode> call(GetGeoCodeUseCaseInput params) {
  return _forecastRepository.getGeoCodeData(lat: params.lat.toString(), lon: params.lon.toString());
  }
}

class GetGeoCodeUseCaseInput {
  final String lat;
  final String lon;

  GetGeoCodeUseCaseInput({required this.lat, required this.lon});
}