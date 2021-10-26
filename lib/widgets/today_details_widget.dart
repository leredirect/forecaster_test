import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forecaster/bloc/current_weather_data_bloc/current_weather_data_bloc.dart';
import 'package:forecaster/models/forecasts_list.dart';
import 'package:forecaster/res/fonts/forecaster_icons.dart';

import '../constants.dart';

class TodayDetailsWidget extends StatelessWidget {
  const TodayDetailsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                child: Column(children: [
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Icon(
                      ForecasterIcons.rain,
                      color: Colors.blue.shade600,
                      size: 25,
                    ),
                  ),
                  Text(state.main.humidity.toString() + " %",
                      style: standardText),
                ]),
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: Column(children: [
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Icon(
                      ForecasterIcons.drop,
                      color: Colors.blue.shade600,
                      size: 25,
                    ),
                  ),
                  Text(
                      state.currentRain.the1H == 0.0
                          ? "0 mm"
                          : state.currentRain.the1H.toString() + " mm",
                      style: standardText),
                ]),
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: Column(children: [
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Icon(
                      ForecasterIcons.pressure,
                      color: Colors.blue.shade600,
                      size: 25,
                    ),
                  ),
                  Text(state.main.pressure.toString() + " hPa",
                      style: standardText),
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
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Icon(
                      ForecasterIcons.wind,
                      color: Colors.blue.shade600,
                      size: 25,
                    ),
                  ),
                  Text(state.wind.speed.toString() + " km/h",
                      style: standardText),
                ]),
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: Column(children: [
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Icon(
                      ForecasterIcons.compass,
                      color: Colors.blue.shade600,
                      size: 25,
                    ),
                  ),
                  Text(state.wind.degreesToRoseOfWind(), style: standardText),
                ]),
              ),
            ],
          ),
        ],
      );
    });
  }
}
