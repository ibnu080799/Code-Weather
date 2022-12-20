import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:code_weather/src/models/weather_model.dart';

class WeatherRepository {
  Future<Weather>? getCurrentWeather(String? location) async {
    var endpoint = Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?q=$location&appid=c06309fda1a5760cd38aa197638fecea");

    var response = await http.get(endpoint);
    var body = jsonDecode(response.body);
    print(Weather.fromJson(body));
    return Weather.fromJson(body);
  }
}
