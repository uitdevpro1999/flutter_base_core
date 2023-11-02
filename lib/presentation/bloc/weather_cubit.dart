import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../../domain/usecases/get_current_weather.dart';
import 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {

  final GetCurrentWeatherUseCase _getCurrentWeatherUseCase;
  WeatherCubit(this._getCurrentWeatherUseCase) : super(WeatherEmpty());
  void getData(String city) async {
    emit(WeatherLoading());
    final result = await _getCurrentWeatherUseCase.getWeather(city);
    result.when(
        failure: (failure) =>
            emit(WeatherLoadFailue(failure.message ?? "Đã có lỗi xảy ra")),
        success: (success) => emit(WeatherLoaded(success))
    );
  }
}