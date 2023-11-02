import 'package:simple_result/simple_result.dart';

import '../../core/error/failures.dart';
import '../entities/weather.dart';

abstract class WeatherRepository {
  Future<Result<WeatherEntity,Failure >> getCurrentWeather(String cityName);
}
