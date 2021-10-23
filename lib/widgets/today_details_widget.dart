import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forecaster/bloc/current_weather_data_bloc/current_weather_data_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forecaster/models/forecasts_list.dart';
import 'package:forecaster/res/fonts/forecaster_icons.dart';

import '../consts.dart';

class TodayDetailsWidget extends StatelessWidget {
  const TodayDetailsWidget({Key? key}) : super(key: key);

  final int index = 1;

  @override
  Widget build(BuildContext context) {
   // CurrentWeather state = context.read<CurrentWeatherDataBloc>().state;
    return BlocBuilder<CurrentWeatherDataBloc, CurrentWeather>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  child: Column(children:[
                    Icon(
                     ForecasterIcons.rain, color: Colors.yellow.shade600, size: 25,
                    ),
                    Text(state.main.humidity.toString() + " %"),
                  ]),
                ),
                Container(
                    margin: EdgeInsets.all(10),
                  child: Column(children: [
                    Icon(
                      ForecasterIcons.drop, color: Colors.yellow.shade600, size: 25,
                    ),
                    Text(state.currentRain.the1H == 0.0?  "0 mm": state.currentRain.the1H.toString() + " mm"),
                  ]),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  child: Column(children: [
                    Icon(
                      ForecasterIcons.pressure, color: Colors.yellow.shade600,size: 25,
                    ),
                    Text(state.main.pressure.toString() + " hPa"),
                  ]),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  child: Column(children: [
                    Icon(
                      ForecasterIcons.wind,color: Colors.yellow.shade600,size: 25,
                    ),
                    Text(state.wind.speed.toString() + " km/h"),
                  ]),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  child: Column(children:  [
                    Icon(
                      ForecasterIcons.compass,color: Colors.yellow.shade600,size: 25,
                    ),
                    Text(state.wind.degreesToRoseOfWind(),),
                  ]),
                ),
              ],
            ),
          ],
        );
      }
    );
  }
}
