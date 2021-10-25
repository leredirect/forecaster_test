import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forecaster/bloc/current_weather_data_bloc/current_weather_data_bloc.dart';
import 'package:forecaster/bloc/current_weather_data_bloc/current_weather_data_event.dart';
import 'package:forecaster/bloc/forecasts_data_bloc/forecasts_data_bloc.dart';
import 'package:forecaster/bloc/forecasts_data_bloc/forecasts_data_event.dart';
import 'package:forecaster/models/forecasts_list.dart';
import 'package:forecaster/res/fonts/forecaster_icons.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';



class Utils {

  static Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied. Try to ');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  static Future<void> showMyDialog(BuildContext context, String title,
      String text, Widget textButton) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: Text(text),
          ),
          actions: <Widget>[
            textButton,
          ],
        );
      },
    );
  }
static final nameToIconMap = {
  //day
  "01d": ForecasterIcons.sun,
  "02d": ForecasterIcons.cloud_sun,
  "03d": ForecasterIcons.cloud,
  "04d": ForecasterIcons.clouds,
  "09d": ForecasterIcons.windy_rain,
  "10d": ForecasterIcons.rain,
  "11d": ForecasterIcons.cloud_flash,
  "13d": ForecasterIcons.snow,
  "50d": ForecasterIcons.mist,
  //night
  "01n": ForecasterIcons.moon,
  "02n": ForecasterIcons.cloud_moon,
  "03n": ForecasterIcons.cloud,
  "04n": ForecasterIcons.clouds,
  "09n": ForecasterIcons.windy_rain,
  "10n": ForecasterIcons.rain,
  "11n": ForecasterIcons.cloud_flash,
  "13n": ForecasterIcons.snow,
  "50n": ForecasterIcons.mist,
};

  static Future<void> responseTransformer(BuildContext context) async {
    try {
      Position locationData = await Utils._determinePosition();

      Response currentWeatherDataResponse =
      await CurrentWeather.fetchCurrentWeather(
          locationData.latitude, locationData.longitude);

      Response forecastsDataResponse = await ForecastsList.fetchForecasts(
          locationData.latitude, locationData.longitude);
      switch (forecastsDataResponse.statusCode &
      currentWeatherDataResponse.statusCode) {
        case 200:
          ForecastsList forecastsData =
          ForecastsList.fromJson(json.decode(forecastsDataResponse.body));
          context
              .read<ForecastsDataBloc>()
              .add(ForecastsDataUpdateEvent(forecastsData));
          CurrentWeather currentWeatherData = CurrentWeather.fromJson(
              json.decode(currentWeatherDataResponse.body));
          context
              .read<CurrentWeatherDataBloc>()
              .add(CurrentWeatherDataUpdateEvent(currentWeatherData));
          break;
        default:
          int statusCode = 0;
          if (currentWeatherDataResponse.statusCode != 200) {
            statusCode = currentWeatherDataResponse.statusCode;
          }
          if (forecastsDataResponse.statusCode != 200) {
            statusCode = currentWeatherDataResponse.statusCode;
          }
          Utils.showMyDialog(context, "Error", "Error code: HTTP $statusCode",
              TextButton(child: const Text("Retry"),
                onPressed: () async {
                  responseTransformer(context);
                  Navigator.of(context).pop();
                },));
      }
    } on Exception catch (e) {
      Utils.showMyDialog(context, "Error", "\n$e", TextButton(child: const Text("Retry"),
        onPressed: () async {
          _determinePosition();
          Navigator.of(context).pop();
        },));
    }
  }

}
