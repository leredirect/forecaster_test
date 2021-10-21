import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forecaster/bloc/location_data_bloc/location_data_bloc.dart';
import 'package:forecaster/bloc/location_data_bloc/location_data_event.dart';
import 'package:location/location.dart';

class Utils {
  static Future<LocationData> fetchLocation(BuildContext context) async {
    Location location = Location();

    bool _serviceEnabled = await location.serviceEnabled();
    PermissionStatus _permissionGranted = await location.hasPermission();
    LocationData _locationData;

    try {
      if (!_serviceEnabled) {
        _serviceEnabled = await location.requestService();
      } else if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await location.requestPermission();
      } else if( _permissionGranted != PermissionStatus.denied && _permissionGranted != PermissionStatus.deniedForever && _serviceEnabled){
        _locationData = await location.getLocation();
        print(_locationData.latitude.toString() +
            _locationData.longitude.toString());
        context
            .read<LocationDataBloc>()
            .add(LocationDataUpdateEvent(_locationData));
        return _locationData;
      }else{
        Utils.showMyDialog(context, "Error", "Error code: Location Permission denied.", "Retry", fetchLocation);
      }
    } on Exception catch (e) {
      print(e);
      fetchLocation(context);
    }
    return fetchLocation(context);
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
