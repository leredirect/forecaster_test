import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forecaster/models/current_weather.dart';
import 'package:forecaster/utils/utils.dart';

import '../constants.dart';

class TodayBrieflyWidget extends StatelessWidget {
  const TodayBrieflyWidget({Key? key, required this.currentWeather})
      : super(key: key);
  final CurrentWeather currentWeather;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Utils.nameToIconMap[currentWeather.currentMetaInfo.first.icon],
          color: Colors.blue.shade600,
          size: 120,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width / 6.5, bottom: 20),
                child: const Icon(
                  Icons.location_on_outlined,
                  size: 10,
                  color: Colors.blue,
                ),
              ),
            ),
            Container(
                margin: const EdgeInsets.all(15),
                child: Text(
                  currentWeather.name +
                      ", " +
                      currentWeather.currentSys.country,
                  style: bigText,
                )),
            const Spacer(),
          ],
        ),
        Text(
          currentWeather.currentBaseInfo.temp.round().toString() +
              "C°" +
              " | " +
              currentWeather.currentMetaInfo.first.description
                  .toString()
                  .toUpperCase(),
          style: blueBigText,
        ),
      ],
    );
  }
}
