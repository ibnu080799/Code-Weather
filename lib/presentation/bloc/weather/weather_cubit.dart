import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:code_weather/data/models/weather_model.dart';
import 'package:code_weather/data/repositories/weather_repository.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final WeatherRepository repository;
  WeatherCubit({required this.repository}) : super(WeatherState.initial());

  Future<void> getWeather({required lat, required long}) async {
    emit(state.copyWith(status: WeatherStatus.loading));
    try {
      final response = await repository.getWeather(
        lat: lat,
        long: long,
      );

      if (response == 'expired') {
        emit(state.copyWith(status: WeatherStatus.expired));
      } else if (response == 'error') {
        emit(state.copyWith(
          status: WeatherStatus.error,
        ));
      }
      emit(state.copyWith(status: WeatherStatus.success, data: response));
      print('sukses = $response');
    } catch (e) {
      emit(state.copyWith(
        status: WeatherStatus.error,
      ));
    }
  }
}
