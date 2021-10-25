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

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  //static Future<LocationData?> fetchLocation(BuildContext context) async {

    /// Determine the current position of the device.
    ///
    /// When the location services are not enabled or permissions
    /// are denied the `Future` will return an error.


    // try {
    // Location location = Location();
    // late LocationData locationData;
    // await location.requestService().then((value) async {
    //   if (value = true) {
    //     await location.hasPermission().then((value) async {
    //       if (value != PermissionStatus.granted) {
    //         await location.requestPermission().then((value) async {
    //           if (value == PermissionStatus.granted ||
    //               value == PermissionStatus.grantedLimited) {
    //             await location.getLocation().then((value) {
    //               locationData = value;
    //               context
    //                   .read<LocationDataBloc>()
    //                   .add(LocationDataUpdateEvent(value));
    //             });
    //           } else {
    //             Utils.showMyDialog(
    //                 context,
    //                 "Error",
    //                 "Error code: Location permission denied.",
    //                 "Retry",
    //                 fetchLocation);
    //           }
    //         });
    //       } else {
    //         await location.getLocation().then((value) {
    //           locationData = value;
    //           context
    //               .read<LocationDataBloc>()
    //               .add(LocationDataUpdateEvent(value));
    //         });
    //       }
    //     });
    //   } else {
    //     Utils.showMyDialog(
    //         context,
    //         "Error",
    //         "Error code: Location service unavailable.",
    //         "Retry",
    //         fetchLocation);
    //   }
    // });
    // return locationData;
    //
    // LocationData _locationData;
    //
    //
    //   if (!_serviceEnabled) {
    //     _serviceEnabled = await location.requestService()
    //   } else if (_permissionGranted == PermissionStatus.denied) {
    //     _permissionGranted = await location.requestPermission();
    //   } else if( _permissionGranted != PermissionStatus.denied && _permissionGranted != PermissionStatus.deniedForever && _serviceEnabled){
    //     _locationData = await location.getLocation();
    //     print(_locationData.latitude.toString() +
    //         _locationData.longitude.toString());
    //     context
    //         .read<LocationDataBloc>()
    //         .add(LocationDataUpdateEvent(_locationData));
    //     return _locationData;
    //   }else{
    //     Utils.showMyDialog(context, "Error", "Error code: Location Permission denied.", "Retry", fetchLocation(context));
    //   }
    // } on Exception catch (e) {
    //   Utils.showMyDialog(context, "Error", "Error code: Platform exception.\n$e", "Retry", fetchLocation(context));
    //   //print(e);
    //   //fetchLocation(context);
    // }
  //}

  static Future<void> showMyDialog(BuildContext context, String title,
      String text, String buttonText, dynamic onButtonTap) async {
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
              child: Text(buttonText),
              onPressed: () async {
                onButtonTap(context);
                Navigator.of(context).pop();
              },
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
          print('41');
          CurrentWeather currentWeatherData = CurrentWeather.fromJson(
              json.decode(currentWeatherDataResponse.body));
          context
              .read<CurrentWeatherDataBloc>()
              .add(CurrentWeatherDataUpdateEvent(currentWeatherData));
          print('44');
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
              "Retry", responseTransformer);
      }
    } on Exception catch (e) {
      Utils.showMyDialog(context, "Error", "Error code: Platform exception.\n$e", "Retry", Utils._determinePosition());
      responseTransformer(context);
    }
  }

}
