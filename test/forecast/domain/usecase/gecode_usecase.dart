import 'package:dartz/dartz.dart';
import 'package:dartz_test/dartz_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_weather/features/forecast/data/data_sources/remote_weather_data_source.dart';
import 'package:my_weather/features/forecast/data/fake_ds.dart';
import 'package:my_weather/features/forecast/data/models/forecast.dart';
import 'package:my_weather/features/forecast/data/repository/whether_repository_implementation.dart';
import 'package:my_weather/features/forecast/domain/repository/i_repo.dart';
import 'package:my_weather/features/forecast/domain/usecases/FetchForecastUsecase.dart';

import 'package:my_weather/utils/data/dio.dart';

class MockWeatherRepositoryImplementation extends Mock
    implements WeatherRepositoryImplementation {}

void main() {
  late WeatherRepositoryImplementation mocRepository;
  late FetchForecastUseCase sut;
  setUp(() {
    mocRepository = MockWeatherRepositoryImplementation();
    sut = FetchForecastUseCase(forecastRepository: mocRepository);
  });

  group('getWhetherData', () {
    test('method call calls getWhetherData function ', () async {
      final input = FetchForecastUseCaseInput(lat: '123', lon: '456');

      when(() => mocRepository.getWhetherData(lat: '123', lon: '456'))
          .thenAnswer((_) async => Right(ForecastModel.fromJson(fakeData)));

      await sut.call(input);

      verify(() => mocRepository.getWhetherData(lat: '123', lon: '456')).called(1);

    });
  });
}
