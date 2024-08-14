import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:my_weather/features/forecast/application/bloc/forecast_bloc.dart';
import 'package:my_weather/features/forecast/domain/entities/view_model.dart';
import 'package:my_weather/features/forecast/presentation/widgets/day.dart';
import 'package:my_weather/features/forecast/presentation/widgets/hour.dart';
import 'package:my_weather/features/forecast/presentation/widgets/minmax.dart';
import 'package:my_weather/features/forecast/presentation/widgets/sun.dart';
import 'package:my_weather/utils/extensions.dart';

class HomeBody extends StatelessWidget {
  HomeBody({
    super.key,
  });
  final ScrollController hScrollController = ScrollController();
  final ScrollController dScrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    final textTheme = Theme.of(context).textTheme;
    return BlocConsumer<ForecastBloc, ForecastState>(
      listener: (context, state) {
       Future.delayed(const Duration(milliseconds: 200),(){ if (state is ForecastLoaded) {
         if (state.selectedDay != null && state.currentHour != null) {
           final ind = state.selectedDay!.hours.indexOf(state.currentHour!);
           hScrollController.animateTo((ind) * (w * .27),
               duration: const Duration(milliseconds: 300),
               curve: Curves.slowMiddle);
         }
         if (state.selectedDay != null) {
           final ind = state.forecastData.days.indexOf(state.selectedDay!);
           dScrollController.animateTo((ind) * (w * .27),
               duration: const Duration(milliseconds: 300),
               curve: Curves.slowMiddle);
         }
       }});
      },
      builder: (context, state) {
        if (state is ForecastLoading) {
          return Center(
            child: SizedBox(
                width: 100,
                height: 100,
                child: Lottie.asset('assets/lottie/earth_sat.json')),
          );
        }
        if (state is ForecastLoadingError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset('assets/lottie/cloud_errr.json'),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    onPressed: () {
                      context.read<ForecastBloc>().add(LoadForecastEvent());

                    },
                    child: Text("Try again"))
              ],
            ),
          );
        }
        if (state is ForecastLoaded) {
          return Scaffold(
            bottomSheet: Container(
              clipBehavior: Clip.hardEdge,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  color: Color.fromRGBO(239, 239, 239, 1)),
              width: double.maxFinite,
              height: MediaQuery.of(context).size.height * .4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: h * .19,
                    child: ListView.separated(
                      controller: hScrollController,
                      shrinkWrap: true,
                      separatorBuilder: (c, i) => SizedBox(
                        width: w * .02,
                      ),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (ctx, index) {
                        final item = state.selectedDay!.hours[index];
                        final isNow = item.time.hour == DateTime.now().hour;
                        return HourWidget(
                            w: w,
                            isNow: isNow,
                            item: item,
                            textTheme: textTheme);
                      },
                      itemCount: state.selectedDay!.hours.length,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: h * .18,
                    child: ListView.separated(
                      controller: dScrollController,
                      shrinkWrap: true,
                      separatorBuilder: (c, i) => SizedBox(
                        width: w * .04,
                      ),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (ctx, index) {
                        final item = state.forecastData.days[index];
                        final isToday =
                            item.date.isSameDate(state.selectedDay!.date);
                        return DayWidget(
                          item: item,
                          isToday: isToday,
                          w: w,
                          textTheme: textTheme,
                          state: state,
                        );
                      },
                      itemCount: state.forecastData.days.length,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            body: SizedBox(
              width: double.maxFinite,
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: [
                  Positioned(
                      left: 0,
                      right: 0,
                      child: Lottie.asset('assets/lottie/cloudy.json',
                          width: double.maxFinite)),
                  Positioned(
                      bottom: h * .3,
                      left: 0,
                      right: 0,
                      top: 0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    state.forecastData.cityName.toUpperCase(),
                                    style: textTheme.bodyMedium
                                        ?.copyWith(color: Colors.white),
                                  ),
                                  const Icon(
                                    Icons.menu,
                                    size: 32,
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(
                                  "Viewing for: ${DateFormat('dd MMM hh:mm a').format(state.currentHour!.time)}",
                                  style: textTheme.bodySmall
                                      ?.copyWith(color: Colors.white)),
                            ),
                            if (state.currentHour != null)
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${state.currentHour?.temp}",
                                    style: textTheme.headlineLarge?.copyWith(
                                        fontSize: 100,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    '°C',
                                    style: textTheme.headlineMedium?.copyWith(
                                        fontSize: 48,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600),
                                  )
                                ],
                              ),
                            MinMaxTemp(
                              state: state,
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            if (state.selectedDay != null)
                              SunData(
                                sunrise: state.selectedDay!.sunrise,
                                sunset: state.selectedDay!.sunset,
                              )
                          ],
                        ),
                      )),
                ],
              ),
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
