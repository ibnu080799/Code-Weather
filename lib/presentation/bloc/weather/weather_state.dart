part of 'weather_cubit.dart';

enum WeatherStatus { initial, loading, success, error, expired }

class WeatherState extends Equatable {
  final WeatherStatus status;
  final dynamic? data;

  const WeatherState({required this.status, required this.data});

  factory WeatherState.initial() {
    return const WeatherState(
      status: WeatherStatus.initial,
      data: null,
    );
  }

  WeatherState copyWith({
    WeatherStatus? status,
    dynamic data,
  }) {
    return WeatherState(
      status: status ?? this.status,
      data: data ?? this.data,
    );
  }

  @override
  String toString() => 'WeatherState(status: $status, data: $data)';

  @override
  List<Object?> get props => [status, data];
}
