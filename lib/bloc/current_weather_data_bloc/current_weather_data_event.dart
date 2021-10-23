import 'package:forecaster/models/forecasts_list.dart';
import 'package:location/location.dart';

class CurrentWeatherDataEvent{}

class CurrentWeatherDataUpdateEvent extends CurrentWeatherDataEvent{
  late CurrentWeather currentWeather;

  CurrentWeatherDataUpdateEvent(this.currentWeather);
}
