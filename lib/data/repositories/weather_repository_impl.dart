import 'dart:io';

import 'package:simple_result/simple_result.dart';

import '../../core/error/failures.dart';
import '../../domain/entities/weather.dart';
import '../../domain/repositories/weather_repository.dart';
import '../data_sources/remote/clients/app_client.dart';
import '../data_sources/remote/interceptors/error_interceptor.dart';

class WeatherRepositoryImpl extends WeatherRepository {
  final AppClient appClient;
  WeatherRepositoryImpl({required this.appClient});

  @override
  Future<Result<WeatherEntity, Failure >> getCurrentWeather(
      String cityName) async {
    try {
      final response = await appClient.getCurrentWeather(cityName);
      // if (response.mess?.code != REQUEST_SUCCESS_CODE) {
      //   return Result.failure(
      //     ResponseFailure(message: response.mess?.description ?? ''),
      //   );
      // }
      return Result.success(response.toEntity());
    } on UnauthorizedException catch (err) {
      return Result.failure(UnauthorizedFailure(message: err.toString()));
    } on ResponseException catch (err) {
      return Result.failure(ResponseFailure(message: err.toString()));
    } on Exception {
      return const Result.failure(UnknownFailure());
    }
  }
}
