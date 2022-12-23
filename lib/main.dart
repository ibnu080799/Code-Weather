import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:code_weather/data/repositories/weather_repository.dart';
import 'package:code_weather/presentation/bloc/weather/weather_cubit.dart';
import 'package:code_weather/presentation/pages/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<WeatherRepository>(
          create: (context) => WeatherRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<WeatherCubit>(
            create: (context) => WeatherCubit(
              repository: context.read<WeatherRepository>(),
            ),
          ),
        ],
        child: MaterialApp(
          title: 'Open Weather Flutter',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const HomePage(),
        ),
      ),
    );
  }
}
