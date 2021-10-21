import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forecaster/bloc/current_weather_data_bloc/current_weather_data_bloc.dart';
import 'package:forecaster/bloc/forecasts_data_bloc/forecasts_data_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forecaster/models/forecasts_list.dart';

class TodayDetailsWidget extends StatelessWidget {
  const TodayDetailsWidget({Key? key}) : super(key: key);

  final int index = 1;

  @override
  Widget build(BuildContext context) {
    CurrentWeather state = context.read<CurrentWeatherDataBloc>().state;
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
                  Icons.wb_sunny_sharp,
                ),
                Text(state.main.humidity.toString() + " %"),
              ]),
            ),
            Container(
                margin: EdgeInsets.all(10),
              child: Column(children: [
                Icon(
                  Icons.wb_sunny_sharp,
                ),
                Text(state.currentRain.the1H.toString() + " mm"),
              ]),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: Column(children: [
                Icon(
                  Icons.wb_sunny_sharp,
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
                  Icons.wb_sunny_sharp,
                ),
                Text(state.wind.speed.toString() + " km/h"),
              ]),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: Column(children:  [
                Icon(
                  Icons.wb_sunny_sharp,
                ),
                Text(state.wind.degreesToRoseOfWind()),
              ]),
            ),
          ],
        ),
      ],
    );
  }
}
