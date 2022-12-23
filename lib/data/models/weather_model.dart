import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class WeatherModel {
  final int id;
  final String name;
  final Map<String, dynamic> main;
  final Map<String, dynamic> wind;
  final List<Map<String, dynamic>> weather;

  WeatherModel({
    required this.id,
    required this.name,
    required this.main,
    required this.wind,
    required this.weather,
  });

  WeatherModel copyWith({
    int? id,
    String? name,
    Map<String, dynamic>? main,
    Map<String, dynamic>? wind,
    List<Map<String, dynamic>>? weather,
  }) {
    return WeatherModel(
      id: id ?? this.id,
      name: name ?? this.name,
      main: main ?? this.main,
      wind: wind ?? this.wind,
      weather: weather ?? this.weather,
    );
  }

  @override
  String toString() {
    return 'WeatherModel(id: $id, name: $name, main: $main, wind: $wind, weather: $weather)';
  }

  WeatherModel _$WeatherModelFromJson(Map<String, dynamic> json) =>
      WeatherModel(
        id: json['id'] as int,
        name: json['name'] as String,
        main: json['main'] as Map<String, dynamic>,
        wind: json['wind'] as Map<String, dynamic>,
        weather: (json['weather'] as List<dynamic>)
            .map((e) => e as Map<String, dynamic>)
            .toList(),
      );

  Map<String, dynamic> _$WeatherModelToJson(WeatherModel instance) =>
      <String, dynamic>{
        'id': instance.id,
        'name': instance.name,
        'main': instance.main,
        'wind': instance.wind,
        'weather': instance.weather,
      };

  factory WeatherModel.fromJson(Map<String, dynamic> json) =>
      _$WeatherModelFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherModelToJson(this);
}
