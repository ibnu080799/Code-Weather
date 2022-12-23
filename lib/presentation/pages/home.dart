// ignore_for_file: unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:code_weather/data/repositories/weather_repository.dart';
import 'package:code_weather/presentation/bloc/weather/weather_cubit.dart';
import 'package:code_weather/utils/style.dart';

import '../widgets/weatherNowWidget.dart';
import '../widgets/currentLocationWidget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late double lat, long;
  String loc = '';

  List listCity = [
    'makassar',
    'palu',
    'ternate',
    'papua',
    'jakarta'
  ];
  List? weatherList = [];

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    _getWeatherByCity();
  }

  Future<void> _getWeatherByCity() async {
    try {
      for (var element in listCity) async {
        print('value = $element');
        WeatherRepository()
            .getWeatherByCity(name: element.toString())
            .then((value) {
          weatherList!.add(value);
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location Services are disabled');
    }
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    await Geolocator.getCurrentPosition().then((value) {
      lat = value.latitude;
      long = value.longitude;
      print('lat : $lat');
      print('long : $long');
      setState(() {
        loc = 'Latittude : $lat ; Longtitude $long';
      });
      context.read<WeatherCubit>().getWeather(lat: lat, long: long);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black26,
      body: SafeArea(
          child: Stack(
        children: [
          ListView(
            shrinkWrap: true,
            children: [
              BlocConsumer<WeatherCubit, WeatherState>(
                listener: (context, state) {
                  if (state.status == WeatherStatus.error) {
                    Center(
                      child: Text(
                        'Opps Gagal Memuat Data!',
                        style: titleTextStyle,
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  if (state.status == WeatherStatus.success) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 80,
                          ),
                          currentLocation(state),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Cuaca Sekitar',
                                style: titleTextStyle,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              CuacaSekitarList(
                                  listCity: listCity, weatherList: weatherList),
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    );
                  }
                  return Column(
                    children: const [
                      SizedBox(
                        height: 150,
                      ),
                      Center(
                        child: CircularProgressIndicator(),
                      ),
                    ],
                  );
                },
              ),
            ],
          )
        ],
      )),
    );
  }
}
