import 'package:flutter/material.dart';
import 'package:flutter_base_core/core/common/router/router.dart';
import 'package:flutter_base_core/presentation/pages/weather/weather_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'injection_container.dart';
import 'presentation/bloc/weather_cubit.dart';

void main() {
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<WeatherCubit>(),
        )
      ],
      child:  MaterialApp.router(
        routerConfig: RouterX().route,
      ),
    );
  }
}


