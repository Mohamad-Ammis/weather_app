
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/Pages/SearchPage.dart';
import 'package:weatherapp/Providers/WeatherProvider.dart';
import 'package:weatherapp/cubits/weather_cubit.dart';
import 'package:weatherapp/cubits/weather_states.dart';
import 'package:weatherapp/models/Weather.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Weather App"),
        
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return SearchPage();
                }));
              },
              icon: Icon(
                Icons.search,
                size: 28,
              )),
        ],
      ),
      body: BlocBuilder<WeatherCubit,WeatherStates>(
        builder: (context, state) {
          if (state is WeatherLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is WeatherSuccess) {
            return succesWidget(weatherData: BlocProvider.of<WeatherCubit>(context).weatherModel!,);
          } else if (state is WeatherFailure) {
            return Center(child: Text("Failure"));
          } else {
            return defaultWidget();
          }
        },
      ),
    );
  }
}

class defaultWidget extends StatelessWidget {
  const defaultWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "there is no weather",
            style: TextStyle(fontSize: 40),
          ),
          Text(
            "Searching now",
            style: TextStyle(fontSize: 40),
          )
        ],
      ),
    );
  }
}

class succesWidget extends StatelessWidget {
  Weather weatherData;
  succesWidget({
    super.key,
    required this.weatherData
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
        colors: [
              weatherData.getThemeColor(),
              weatherData.getThemeColor()[50]!,
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      )),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(
            flex: 3,
          ),
          Text(
            BlocProvider.of<WeatherCubit>(context).cityName!,
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          Text(
            "updated: ${weatherData.time}",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Spacer(
            flex: 1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(weatherData.getImage()),
              Text(
                "${weatherData.temp}",
                style: TextStyle(
                    fontSize: 32, fontWeight: FontWeight.bold),
              ),
              Column(
                children: [
                  Text(
                      "minTemp=${weatherData.minTemp}",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(
                      "maxTemp=${weatherData.maxTemp}",
                      style: TextStyle(fontWeight: FontWeight.bold))
                ],
              )
            ],
          ),
          Spacer(
            flex: 1,
          ),
          Text(
            "${weatherData.weatherStateName}",
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          Spacer(
            flex: 4,
          ),
        ],
      ),
    );
  }
}
