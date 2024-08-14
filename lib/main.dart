import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_weather/pages/screen_home.dart';
import 'package:my_weather/pages/screen_splash.dart';
import 'package:my_weather/utils/bloc/observer.dart';
import 'package:my_weather/utils/di/di.dart';

import 'features/forecast/application/bloc/forecast_bloc.dart';
import 'features/forecast/data/repository/whether_repository_implementation.dart';

GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();
  await ServiceLocator.setUpDep();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ForecastBloc(ServiceLocator.getIt<WeatherRepositoryImplementation>())
            ..add(LoadForecastEvent()),
      child: MaterialApp(
        navigatorKey: navKey,
        title: 'Weather app',
        theme: ThemeData(
          textTheme: Theme.of(context).textTheme.copyWith(
            headlineSmall: TextStyle(fontSize: 22),
              bodyMedium: const TextStyle(fontSize: 20),
              bodyLarge:
                  const TextStyle(fontSize: 32, fontWeight: FontWeight.w500),
              bodySmall: TextStyle(fontSize: 16)),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
