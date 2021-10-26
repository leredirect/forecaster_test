import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forecaster/models/forecasts_list.dart';

import 'forecasts_data_event.dart';

class ForecastsDataBloc extends Bloc<ForecastsDataEvent, ForecastsList> {
  ForecastsDataBloc()
      : super(ForecastsList(
            cod: "cod",
            message: 0,
            cnt: 0,
            list: [],
            city: City(
                sunrise: 0,
                timezone: 0,
                sunset: 0,
                id: 0,
                country: '',
                name: '',
                population: 0)));

  @override
  Stream<ForecastsList> mapEventToState(ForecastsDataEvent event) async* {
    if (event is ForecastsDataUpdateEvent) {
      yield event.forecastsList;
    }
  }
}
