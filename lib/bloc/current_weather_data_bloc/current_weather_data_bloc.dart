import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forecaster/models/forecasts_list.dart';

import 'current_weather_data_event.dart';

class CurrentWeatherDataBloc
    extends Bloc<CurrentWeatherDataEvent, CurrentWeather> {
  CurrentWeatherDataBloc()
      : super(CurrentWeather(
            currentRain: CurrentRain(the1H: 0, the3H: 0),
            visibility: 0,
            base: '',
            id: 0,
            cod: 0,
            clouds: Clouds(all: 0),
            currentSys:
                CurrentSys(country: '', id: 0, sunset: 0, type: 0, sunrise: 0),
            main: Main(
                temp: 0,
                feelsLike: 0,
                tempMin: 0,
                tempMax: 0,
                pressure: 0,
                humidity: 0,
                seaLevel: 0,
                grndLevel: 0),
            weather: [],
            name: '',
            dt: 0,
            wind: Wind(speed: 0, deg: 0, gust: 0),
            timezone: 0));

  @override
  Stream<CurrentWeather> mapEventToState(CurrentWeatherDataEvent event) async* {
    if (event is CurrentWeatherDataUpdateEvent) {
      yield state.copyWith(event.currentWeather);
    }
  }
}
