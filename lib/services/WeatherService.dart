import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:weatherapp/models/Weather.dart';

class WeatherService {
  String baseUrl = 'http://api.weatherapi.com/v1';
  String apiKey = '55fe18e266344297a95201552230110';
  Future<Weather> getWeather({required String cityName}) async {
    Uri url = Uri.parse(
        "$baseUrl/forecast.json?key=$apiKey&q=$cityName&days=7&aqi=no&alerts=no");
    Response response = await http.get(url);
    Map<String, dynamic> data = jsonDecode(response.body);
    Weather weather = Weather.fromJson(data);
    return weather;
  }
}
