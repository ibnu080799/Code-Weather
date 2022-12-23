import 'package:flutter/material.dart';

import '../../utils/style.dart';
import '../bloc/weather/weather_cubit.dart';

Column currentLocation(WeatherState state) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Builder(builder: (context) {
            if (state.data.weather[0]['main'] == 'Clouds') {
              return Image.asset(
                "assets/images/berawan.png",
                width: 90,
              );
            } else if (state.data.weather[0]['main'] == 'Rain') {
              return Image.asset(
                "assets/images/hujan_siang.png",
                width: 90,
              );
            } else if (state.data.weather[0]['main'] == 'Haze') {
              return Image.asset(
                "assets/images/hujan_malam.png",
                width: 90,
              );
            } else {
              return Image.asset(
                "assets/images/petir.png",
                width: 90,
              );
            }
          }),
          const SizedBox(
            width: 15,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                state.data.name,
                style: titleTextStyle,
              ),
              Text(
                state.data.weather[0]['main'],
                style: titleTextStyle,
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Image.asset(
                    'assets/images/wind.png',
                    height: 15,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    '${state.data.wind['speed'].toString()}/KM',
                    style: titleTextStyle.copyWith(fontSize: 10),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      Text(
        '${state.data.main['temp']} °C',
        style: titleTextStyle,
      ),
      const SizedBox(
        height: 30,
      ),
    ],
  );
}
