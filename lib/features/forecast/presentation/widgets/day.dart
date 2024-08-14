import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:my_weather/features/forecast/application/bloc/forecast_bloc.dart';
import 'package:my_weather/features/forecast/domain/entities/view_model.dart';

class DayWidget extends StatelessWidget {
  const DayWidget({
    super.key,
    required this.item,
    required this.isToday,
    required this.w,
    required this.textTheme, required this.state,
  });
  final ForecastLoaded state;
  final ADayData item;
  final bool isToday;
  final double w;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<ForecastBloc>().add(
            SetSelectedDayEvent(
                aDayData: item,
                viewData: state.forecastData));
      },
      child: Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
              color: isToday
                  ? Colors.white
                  : const Color.fromRGBO(239, 239, 239, 1),
              boxShadow: !isToday
                  ? null
                  : [
                const BoxShadow(
                  blurRadius: 8,
                  color: Color(0xffa7a7a7),
                  offset: Offset(
                    6,
                    6,
                  ),
                ),
                const BoxShadow(
                  blurRadius: 12,
                  color: Color(0xffffffff),
                  offset: Offset(
                    -6,
                    -6,
                  ),
                ),
              ],
              gradient: null,
              borderRadius:
              const BorderRadius.all(Radius.circular(
                12,
              ))),
          width: w * .28,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment:
            MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  const Icon(Icons.arrow_upward_rounded),
                  Text(
                    item.max.toString() + "°C",
                    style: textTheme.headlineSmall,
                  ),
                ],
              ),
              Text(
                DateFormat('dd MMM').format(item.date),
                style: textTheme.headlineMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  const Icon(Icons.arrow_downward_rounded),
                  Text(
                    item.min.toString() + "°C",
                    style: textTheme.headlineSmall,
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
