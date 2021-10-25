import 'package:forecaster/models/forecasts_list.dart';

class CurrentWeatherDataEvent{}

class CurrentWeatherDataUpdateEvent extends CurrentWeatherDataEvent{
  late CurrentWeather currentWeather;

  CurrentWeatherDataUpdateEvent(this.currentWeather);
}
