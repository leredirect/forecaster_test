import 'package:forecaster/models/current_weather.dart';

class CurrentWeatherDataEvent {}

class CurrentWeatherDataUpdateEvent extends CurrentWeatherDataEvent {
  late CurrentWeather currentWeather;

  CurrentWeatherDataUpdateEvent(this.currentWeather);
}
