import 'package:flutter_bloc/flutter_bloc.dart';

import 'current_weather_data_event.dart';
import 'current_weather_state.dart';

class CurrentWeatherDataBloc
    extends Bloc<CurrentWeatherDataEvent, CurrentWeatherState> {
  CurrentWeatherDataBloc() : super(CurrentWeatherLoadingState());

  @override
  Stream<CurrentWeatherState> mapEventToState(
      CurrentWeatherDataEvent event) async* {
    if (event is CurrentWeatherDataUpdateEvent) {
      yield CurrentWeatherDataState(event.currentWeather);
    }
  }
}
