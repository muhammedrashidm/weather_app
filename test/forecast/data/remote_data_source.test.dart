import 'package:dartz/dartz.dart';
import 'package:dartz_test/dartz_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_weather/features/forecast/data/data_sources/remote_weather_data_source.dart';
import 'package:my_weather/features/forecast/data/fake_ds.dart';
import 'package:my_weather/features/forecast/data/models/forecast.dart';

import 'package:my_weather/utils/data/dio.dart';

class MockDataSorce extends Mock implements RemoteWeatherDataSource {}

void main() {
  late MockDataSorce mockDataSorce;
  setUp(() {
    mockDataSorce = MockDataSorce();
  });

  group('getWhetherData', () {
    test('returns ForecastModel from valid JSON', () async {
      when(() => mockDataSorce.getWhetherData(lat: '123', lon: '456'))
          .thenAnswer((_) async => Right(ForecastModel.fromJson(fakeData)));
      final result =
          await mockDataSorce.getWhetherData(lat: '123', lon: '456');

      expect(result, isRightThat( ForecastModel()));
      result.fold((l){}, (r){
        print(r.longitude);
      });
    });
  });
}
