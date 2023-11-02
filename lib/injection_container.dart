import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'core/constants/constants.dart';
import 'data/data_sources/remote/clients/app_client.dart';
import 'data/data_sources/remote/dio_di.dart';
import 'data/repositories/weather_repository_impl.dart';
import 'domain/repositories/weather_repository.dart';
import 'domain/usecases/get_current_weather.dart';
import 'presentation/bloc/weather_cubit.dart';
import 'package:http/http.dart' as http;

final getIt = GetIt.instance;

void configureDependencies() {

  // bloc
  getIt.registerFactory(() => WeatherCubit(getIt()));

  // usecase
  getIt.registerLazySingleton(() => GetCurrentWeatherUseCase(getIt()));
  // repository
  getIt.registerLazySingleton<WeatherRepository>(
    () => WeatherRepositoryImpl(
      appClient: getIt()
    ),
  );
  // data source
  getIt.registerLazySingleton<AppClient>(
    () => AppClient(
      getIt<Dio>(),
      baseUrl: Urls.baseUrl
    ),
  );
  // external
  getIt.registerLazySingleton(() => _DioDi().dio);
}
class _DioDi extends DioDi {}
