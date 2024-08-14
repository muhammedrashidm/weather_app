import 'package:flutter/material.dart';
import 'package:my_weather/features/forecast/application/bloc/forecast_bloc.dart';

class MinMaxTemp extends StatelessWidget {
  const MinMaxTemp({
    super.key,
    required this.state,
  });
  final ForecastLoaded state;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: const Color.fromRGBO(239, 239, 239, 1)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Text("${state.selectedDay?.max} °C"),
              const Icon(Icons.arrow_upward_rounded)
            ],
          ),
          const SizedBox(
            width: 10,
          ),
          Row(
            children: [
              Text("${state.selectedDay?.min} °C"),
              const Icon(Icons.arrow_downward_rounded)
            ],
          ),
        ],
      ),
    );
  }
}
