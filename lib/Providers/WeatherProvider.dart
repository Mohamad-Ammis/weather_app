import 'package:flutter/material.dart';
import 'package:weatherapp/models/Weather.dart';

class WeatherProvider extends ChangeNotifier {
  Weather? _weatherdata;
  String? cityName;
  set weatherdata(Weather? weather) {
    _weatherdata = weather;
    notifyListeners();
  }

  Weather? get weatherdata => _weatherdata;
}
