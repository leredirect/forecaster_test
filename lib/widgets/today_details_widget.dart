import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forecaster/models/current_weather.dart';
import 'package:forecaster/utils/forecaster_icons.dart';

import '../constants.dart';

class TodayDetailsWidget extends StatelessWidget {
  const TodayDetailsWidget({Key? key, required this.currentWeather})
      : super(key: key);
  final CurrentWeather currentWeather;

  @override
  Widget build(BuildContext context) {
    EdgeInsets margin = const EdgeInsets.all(10);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: margin,
              child: Column(children: [
                Container(
                  margin: margin,
                  child: Icon(
                    ForecasterIcons.rain,
                    color: Colors.blue.shade600,
                    size: 25,
                  ),
                ),
                Text(currentWeather.currentBaseInfo.humidity.toString() + " %",
                    style: standardText),
              ]),
            ),
            Container(
              margin: margin,
              child: Column(children: [
                Container(
                  margin: margin,
                  child: Icon(
                    ForecasterIcons.drop,
                    color: Colors.blue.shade600,
                    size: 25,
                  ),
                ),
                Text(
                    currentWeather.currentRain.the1H == 0.0
                        ? "0 mm"
                        : currentWeather.currentRain.the1H.toString() + " mm",
                    style: standardText),
              ]),
            ),
            Container(
              margin: margin,
              child: Column(children: [
                Container(
                  margin: margin,
                  child: Icon(
                    ForecasterIcons.pressure,
                    color: Colors.blue.shade600,
                    size: 25,
                  ),
                ),
                Text(
                    currentWeather.currentBaseInfo.pressure.toString() + " hPa",
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
              margin: margin,
              child: Column(children: [
                Container(
                  margin: margin,
                  child: Icon(
                    ForecasterIcons.wind,
                    color: Colors.blue.shade600,
                    size: 25,
                  ),
                ),
                Text(currentWeather.currentWind.speed.toString() + " km/h",
                    style: standardText),
              ]),
            ),
            Container(
              margin: margin,
              child: Column(children: [
                Container(
                  margin: margin,
                  child: Icon(
                    ForecasterIcons.compass,
                    color: Colors.blue.shade600,
                    size: 25,
                  ),
                ),
                Text(currentWeather.currentWind.degreesToRoseOfWind(),
                    style: standardText),
              ]),
            ),
          ],
        ),
      ],
    );
  }
}
