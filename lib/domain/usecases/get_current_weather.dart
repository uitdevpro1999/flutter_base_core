import 'package:simple_result/simple_result.dart';

import '../../core/error/failures.dart';
import '../entities/weather.dart';
import '../repositories/weather_repository.dart';

class GetCurrentWeatherUseCase {
  final WeatherRepository weatherRepository;

  GetCurrentWeatherUseCase(this.weatherRepository);

  Future<Result<WeatherEntity,Failure >> getWeather(String cityName) {
    return weatherRepository.getCurrentWeather(cityName);
  }
}
