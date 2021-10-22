import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forecaster/bloc/current_weather_data_bloc/current_weather_data_bloc.dart';
import 'package:forecaster/models/forecasts_list.dart';

class TodayBrieflyWidget extends StatelessWidget {
  const TodayBrieflyWidget({Key? key}) : super(key: key);

  //const TodayBrieflyWidget(CurrentWeather currentWeather, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //CurrentWeather state = context.read<CurrentWeatherDataBloc>().state;
    return BlocBuilder<CurrentWeatherDataBloc, CurrentWeather>(
        builder: (context, state) {

          if (state.weather.isNotEmpty){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.wb_sunny_sharp,
            size: 100,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  margin: const EdgeInsets.only(right: 15, bottom: 20),
                  child: const Icon(
                    Icons.location_on,
                    size: 10,
                  )),
              Text(state.name + ", " + state.currentSys.country),
            ],
          ),
          Text(state.main.temp.round().toString() +
              "C°" +
              " | " +
              state.weather.first.description.toString()),
        ],
      );}else{
            return Placeholder();
          }
    });
  }
}
