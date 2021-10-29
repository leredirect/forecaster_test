import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forecaster/bloc/forecasts_data_bloc/forecasts_state.dart';

import 'forecasts_data_event.dart';

class ForecastsDataBloc extends Bloc<ForecastsDataEvent, ForecastState> {
  ForecastsDataBloc() : super(ForecastLoadingState());

  @override
  Stream<ForecastState> mapEventToState(ForecastsDataEvent event) async* {
    if (event is ForecastsDataUpdateEvent) {
      yield ForecastDataState(event.forecastsList);
    }
  }
}
