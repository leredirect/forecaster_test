import 'package:forecaster/models/forecasts_list.dart';

class ForecastsDataEvent {}

class ForecastsDataUpdateEvent extends ForecastsDataEvent {
  late ForecastsList forecastsList;

  ForecastsDataUpdateEvent(this.forecastsList);
}
