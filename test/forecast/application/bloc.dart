import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_weather/features/forecast/application/bloc/forecast_bloc.dart';
import 'package:my_weather/features/forecast/data/repository/whether_repository_implementation.dart';
import 'package:my_weather/features/forecast/domain/entities/view_model.dart';
import 'package:my_weather/features/forecast/domain/usecases/FetchForecastUsecase.dart';

class MockWeatherRepositoryImplementation extends Mock
    implements WeatherRepositoryImplementation {}

void main() {
  late WeatherRepositoryImplementation mocRepository;
  late FetchForecastUseCase sut;
  setUp(() {
    mocRepository = MockWeatherRepositoryImplementation();
    sut = FetchForecastUseCase(forecastRepository: mocRepository);
  });

  blocTest<ForecastBloc, ForecastState>(
    'emits a state when LoadForecastEvent is added',
    build: () => ForecastBloc(mocRepository),
    act: (bloc) => bloc.add(LoadForecastEvent()),
    seed: () => ForecastLoaded(
        forecastData: ViewData(timeZone: '', days: [], cityName: '')),
    expect: () => [
     
      ForecastLoading(),ForecastLoadingError(cause: '')
    ],
  );
}
