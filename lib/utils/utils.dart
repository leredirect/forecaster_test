import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forecaster/bloc/current_weather_data_bloc/current_weather_data_bloc.dart';
import 'package:forecaster/bloc/current_weather_data_bloc/current_weather_data_event.dart';
import 'package:forecaster/bloc/forecasts_data_bloc/forecasts_data_bloc.dart';
import 'package:forecaster/bloc/forecasts_data_bloc/forecasts_data_event.dart';
import 'package:forecaster/models/current_weather.dart';
import 'package:forecaster/models/forecasts_list.dart';
import 'package:forecaster/networking/api_client.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';

import 'forecaster_icons.dart';

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
    } else if (permission == LocationPermission.deniedForever) {
      throw Exception(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  static Future<void> showMyDialog(BuildContext context, String title,
      String text, String buttonText, onTap) async {
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
            TextButton(
              child: const Text("Ok"),
              onPressed: onTap,
            ),
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

  static Future<void> forecastsResponseTransformer(BuildContext context) async {
    ConnectivityResult connection = await Connectivity().checkConnectivity();
    if (connection != ConnectivityResult.none) {
      try {
        Position locationData = await Utils._determinePosition();

        Response forecastsDataResponse = await ApiClient.fetchForecasts(
            locationData.latitude, locationData.longitude);

        ForecastsList forecastsData =
            ForecastsList.fromJson(json.decode(forecastsDataResponse.body));
        context
            .read<ForecastsDataBloc>()
            .add(ForecastsDataUpdateEvent(forecastsData));
      } on Exception catch (e) {
        Utils.showMyDialog(context, "Error", "\n$e", "Retry", () async {
          _determinePosition();
          Navigator.of(context).pop();
        });
      }
    } else {
      Utils.showMyDialog(context, "Error", "No internet connection", "Ok",
          () async {
        Navigator.of(context).pop();
      });
      return;
    }
  }

  static Future<void> currentWeatherResponseTransformer(
      BuildContext context) async {
    ConnectivityResult connection = await Connectivity().checkConnectivity();
    if (connection != ConnectivityResult.none) {
      try {
        Position locationData = await Utils._determinePosition();

        Response currentWeatherDataResponse =
            await ApiClient.fetchCurrentWeather(
                locationData.latitude, locationData.longitude);
        CurrentWeather currentWeatherData = CurrentWeather.fromJson(
            json.decode(currentWeatherDataResponse.body));
        context
            .read<CurrentWeatherDataBloc>()
            .add(CurrentWeatherDataUpdateEvent(currentWeatherData));
      } on Exception catch (e) {
        Utils.showMyDialog(context, "Error", "\n$e", "Retry", () async {
          _determinePosition();
          Navigator.of(context).pop();
        });
      }
    } else {
      Utils.showMyDialog(context, "Error", "No internet connection", "Ok",
          () async {
        Navigator.of(context).pop();
      });
      return;
    }
  }

  static int indexToInnerIndex(int innerIndex, int index, int firstDayLength) {
    int result = 0;
    if (index == 0) {
      result = innerIndex;
    } else if (index == 1) {
      result = innerIndex + firstDayLength;
    } else if (index == 2) {
      result = innerIndex + firstDayLength + 8;
    } else if (index == 3) {
      result = innerIndex + firstDayLength + 16;
    } else if (index == 4) {
      result = innerIndex + firstDayLength + 24;
    }
    return result;
  }

  static int listBuilderItemCount(int index, ForecastsList forecastList) {
    List result = forecastList.forecastBaseInfoList
        .where((element) =>
            DateTime.fromMillisecondsSinceEpoch(element.dt * 1000).day ==
            DateTime.now().day)
        .toList();
    if (index == 0) {
      return result.length;
    } else {
      return 8;
    }
  }
}
