import 'package:dio/dio.dart';

import '../../utils/constant.dart';

class WeatherServices {
  Dio dio = Dio();

  Future getWeatherServices({required lat, required long}) async {
    try {
      return await dio.get(
          "$URL/weather?units=metric&lat=$lat&lon=$long&appid=$KEY",
          options: Options(
              followRedirects: false,
              validateStatus: (status) => true,
              headers: {
                "Content-Type": "application/json",
              }));
    } catch (e) {
      print('error getWeatherServices = $e');
      return e;
    }
  }

  Future getWeatherByCityServices({required name}) async {
    try {
      return await dio.get("$URL/weather?units=metric&q=$name&appid=$KEY",
          options: Options(
              followRedirects: false,
              validateStatus: (status) => true,
              headers: {
                "Content-Type": "application/json",
              }));
    } catch (e) {
      print('error getWeatherByCityServices = $e');
      return e;
    }
  }
}
