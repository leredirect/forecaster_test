import 'package:forecaster/models/current_weather.dart';

abstract class CurrentWeatherState {}

class CurrentWeatherLoadingState extends CurrentWeatherState {}

class CurrentWeatherDataState extends CurrentWeatherState {
  final CurrentWeather currentWeather;

  CurrentWeatherDataState(this.currentWeather);
}
