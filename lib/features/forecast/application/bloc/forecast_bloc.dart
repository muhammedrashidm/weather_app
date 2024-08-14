import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_weather/features/forecast/domain/entities/forecast.dart';
import 'package:my_weather/features/forecast/domain/entities/view_model.dart';
import 'package:my_weather/features/forecast/domain/repository/i_repo.dart';
import 'package:my_weather/features/forecast/domain/usecases/FetchForecastUsecase.dart';
import 'package:my_weather/features/forecast/domain/usecases/GetGeoCodeUseCase.dart';
import 'package:my_weather/utils/device_services/location.dart';
import 'package:my_weather/utils/extensions.dart';
import 'package:collection/collection.dart'; // You have to add this manually, for some reason it cannot be added automatically

part 'forecast_event.dart';
part 'forecast_state.dart';

class ForecastBloc extends Bloc<ForecastEvent, ForecastState> {
  final IWhetherForecastRepository _forecastRepository;
  ForecastBloc(this._forecastRepository) : super(ForecastInitial()) {
    on<LoadForecastEvent>((event, emit) async {
      emit(ForecastLoading());

      final location = await MyLocation.getLocation();

      if (location != null) {
        FetchForecastUseCase useCase =
            FetchForecastUseCase(forecastRepository: _forecastRepository);
        final result = await useCase(FetchForecastUseCaseInput(
            lat: location!.latitude.toString(),
            lon: location.longitude.toString()));
        GetGeoCodeUseCase geoCodeUseCase =
            GetGeoCodeUseCase(forecastRepository: _forecastRepository);
        final geocode = await geoCodeUseCase.call(GetGeoCodeUseCaseInput(
            lat: location!.latitude.toString(),
            lon: location.longitude.toString()));
        String cityName = '';
        geocode.fold((l) {}, (r) {
          cityName =
              "${r.address?.city ?? r.address?.suburb ?? r.address?.stateDistrict ?? ''}, ${r.address?.countryCode ?? ''}";
        });
        return result.fold((l) {
          return emit(ForecastLoadingError(cause: l.cause));
        }, (r) {
          final converted = r.toViewData();
          final selected = converted.days
              .firstWhere((e) => e.date.isSameDate(DateTime.now()));
          converted.cityName = cityName;
          final currentHour = selected.hours
              .firstWhere((e) => e.time.isSameHour(DateTime.now()));
          return emit(ForecastLoaded(
              forecastData: converted,
              selectedDay: selected,
              currentHour: currentHour));
        });
      } else {
        return emit(ForecastLoadingError(cause: "Unable to access location"));
      }
    });

    on<SetSelectedDayEvent>((event, emit) {
      final AHourData? currentHour = event.aDayData.hours
          .firstWhereOrNull((e) => e.time.isSameHour(DateTime.now()));
      emit(ForecastLoaded(
          selectedDay: event.aDayData,
          forecastData: event.viewData,
          currentHour: currentHour));
    });
  }
}
