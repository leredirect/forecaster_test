import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forecaster/bloc/location_access_bloc/location_access_bloc.dart';
import 'package:forecaster/bloc/location_access_bloc/location_access_event.dart';
import 'package:forecaster/bloc/location_data_bloc/location_data_bloc.dart';
import 'package:forecaster/bloc/location_data_bloc/location_data_event.dart';
import 'package:location/location.dart';

class Utils {
  static Future<void> fetchLocation(BuildContext context) async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    try {
      _serviceEnabled = await location.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await location.requestService();
        if (!_serviceEnabled) {
          return;
        }
      }

      _permissionGranted = await location.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await location.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          return;
        }
      }

      _locationData = await location.getLocation();
      print(_locationData.latitude.toString() + _locationData.longitude.toString());
      context.read<LocationDataBloc>().add(LocationDataUpdateEvent(_locationData));
      await Future.delayed(Duration(seconds: 3));
    } on Exception catch (e) {
      print (e);
      fetchLocation(context);
    }
  }

  static Future<void> showMyDialog(BuildContext context, String title,
      String text, String buttonText, Function onButtonTap) async {
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
              onPressed: () {
                onButtonTap();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
