import 'package:flutter/material.dart';
import 'package:flutter_base_core/presentation/pages/home/home_page.dart';
import'package:go_router/go_router.dart';
import 'package:flutter/foundation.dart';

import '../../../presentation/pages/weather/weather_page.dart';

class RouterX{
  GoRouter route = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const HomePage();
        },
        routes: <RouteBase>[
          GoRoute(
            path: 'weather',
            builder: (BuildContext context, GoRouterState state) {
              return const WeatherPage();
            },
          ),
        ],
      ),
    ],
  );
}

