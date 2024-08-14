import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:my_weather/features/forecast/application/bloc/forecast_bloc.dart';
import 'package:my_weather/features/forecast/data/repository/whether_repository_implementation.dart';
import 'package:my_weather/features/forecast/domain/repository/i_repo.dart';
import 'package:my_weather/utils/di/di.dart';

import '../features/forecast/presentation/home.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      body: HomeBody(),
    );
  }
}

