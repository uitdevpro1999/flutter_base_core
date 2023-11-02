import 'package:dio/dio.dart';
import 'package:retrofit/http.dart' as http;
import 'package:retrofit/retrofit.dart';

import '../../../models/weather_model.dart';

part 'app_client.g.dart';

@RestApi()
abstract class AppClient {
  factory AppClient(
      Dio dio, {
        String baseUrl,
      }) = _AppClient;
  @GET('/weather?q={city}&appid=cc95d932d5a45d33a9527d5019475f2c')
  Future<WeatherModel> getCurrentWeather(
      @Path('city') String cityName,
      );
}