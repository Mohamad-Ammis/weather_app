import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/Pages/HomePage.dart';
import 'package:weatherapp/cubits/weather_cubit.dart';
import 'package:weatherapp/services/WeatherService.dart';

void main() {
  runApp(BlocProvider(
      create: (context) {
        return WeatherCubit(weatherService: WeatherService());
      },
      child: MyApp()));
}

dynamic x = 'dark';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primarySwatch:
              BlocProvider.of<WeatherCubit>(context).weatherModel == null
                  ? Colors.blue
                  : BlocProvider.of<WeatherCubit>(context)
                      .weatherModel!
                      .getThemeColor()),
      home: HomePage(),
    );
  }
}
