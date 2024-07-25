import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/Providers/WeatherProvider.dart';
import 'package:weatherapp/cubits/weather_cubit.dart';
import 'package:weatherapp/models/Weather.dart';
import 'package:weatherapp/services/WeatherService.dart';

// ignore: must_be_immutable
class SearchPage extends StatelessWidget {
  VoidCallback? updateUI;
  String? cityName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Search a City",
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: TextField(
            onSubmitted: (data) async {
              cityName=data;
              BlocProvider.of<WeatherCubit>(context).getWeather(cityName: cityName!);
              BlocProvider.of<WeatherCubit>(context).cityName=cityName;
              Navigator.pop(context);
            },
            decoration: const InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(vertical: 30, horizontal: 24),
              border: OutlineInputBorder(),
              suffixIcon: Icon(Icons.search),
              label: Text('Search'),
              hintText: "Enter a City name",
            ),
          ),
        ),
      ),
    );
  }
}
