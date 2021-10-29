import 'package:forecaster/models/forecasts_list.dart';

abstract class ForecastState {}

class ForecastLoadingState extends ForecastState {}

class ForecastDataState extends ForecastState {
  final ForecastsList forecastList;

  ForecastDataState(this.forecastList);
}
