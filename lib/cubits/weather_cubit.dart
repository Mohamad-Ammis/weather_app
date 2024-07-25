import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/cubits/weather_states.dart';
import 'package:weatherapp/models/Weather.dart';
import 'package:weatherapp/services/WeatherService.dart';

class WeatherCubit extends Cubit<WeatherStates> {
  WeatherCubit({required this.weatherService}) : super(WeatherInitial());
  WeatherService weatherService;
  Weather? weatherModel;
  String ? cityName;
  void getWeather({required String cityName}) async {
    emit(WeatherLoading());
    try {
      weatherModel = await weatherService.getWeather(cityName: cityName);
      emit(WeatherSuccess());
    } on Exception catch (e) {
      emit(WeatherFailure());
    }
  }
}
