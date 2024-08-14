import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_weather/features/forecast/application/bloc/forecast_bloc.dart';
import 'package:my_weather/main.dart';
import 'package:my_weather/pages/screen_home.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error,
              color: Colors.redAccent,
              size: 100,
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () {
                  context.read<ForecastBloc>().add(LoadForecastEvent());
                  navKey.currentState?.pushReplacement(
                      MaterialPageRoute(builder: (context) => ScreenHome()));
                },
                child: Text("Try again"))
          ],
        ),
      ),
    );
  }
}
