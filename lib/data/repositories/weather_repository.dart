import 'package:dio/dio.dart';
import 'package:code_weather/data/models/weather_model.dart';
import 'package:code_weather/data/services/weather_services.dart';

class WeatherRepository {
  Future getWeather({required lat, required long}) async {
    try {
      final Response res =
          await WeatherServices().getWeatherServices(lat: lat, long: long);
      if (res.statusCode == 200) {
        return WeatherModel.fromJson(res.data);
      } else if (res.statusCode == 403 || res.statusCode == 401) {
        return "expired";
      } else {
        return "error";
      }
    } catch (e) {
      print('error repository getWeather = $e');
      return "error";
    }
  }

  Future getWeatherByCity({required name}) async {
    try {
      final Response res =
          await WeatherServices().getWeatherByCityServices(name: name);
      if (res.statusCode == 200) {
        return WeatherModel.fromJson(res.data);
      } else if (res.statusCode == 403 || res.statusCode == 401) {
        return "expired";
      } else {
        return "error";
      }
    } catch (e) {
      print('error repository getWeatherByCity = $e');
      return "error";
    }
  }
}
