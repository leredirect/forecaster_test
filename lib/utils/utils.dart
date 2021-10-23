import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forecaster/bloc/location_data_bloc/location_data_bloc.dart';
import 'package:forecaster/bloc/location_data_bloc/location_data_event.dart';
import 'package:location/location.dart';

class Utils {
  static Future<LocationData> fetchLocation(BuildContext context) async {
    // try {
    Location location = Location();
    late LocationData locationData;
    await location.requestService().then((value) async {
      if (value = true) {
        await location.hasPermission().then((value) async {
          if (value != PermissionStatus.granted) {
            await location.requestPermission().then((value) async {
              if (value == PermissionStatus.granted || value == PermissionStatus.grantedLimited) {
                await location.getLocation().then((value) {
                  locationData = value;
                  context
                      .read<LocationDataBloc>()
                      .add(LocationDataUpdateEvent(value));
                });
              } else {
                Utils.showMyDialog(
                    context,
                    "Error",
                    "Error code: Location permission denied.",
                    "Retry",
                    fetchLocation);
              }
            });
          } else {
            Utils.showMyDialog(
                context,
                "Error",
                "Error code: Location permission denied.",
                "Retry",
                fetchLocation);
          }
        });
      } else {
        Utils.showMyDialog(
            context,
            "Error",
            "Error code: Location service unavailable.",
            "Retry",
            fetchLocation);
      }
    });
    return locationData;
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
  }

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
}
