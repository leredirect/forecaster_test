import 'package:flutter/cupertino.dart';
import 'package:forecaster/bloc/location_access_bloc/location_access_bloc.dart';
import 'package:forecaster/bloc/location_access_bloc/location_access_event.dart';
import 'package:forecaster/bloc/location_data_bloc/location_data_bloc.dart';
import 'package:forecaster/bloc/location_data_bloc/location_data_event.dart';
import 'package:location/location.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Utils{
  static Future<void> fetchLocation(BuildContext context) async {
    Location location = Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      context.read<LocationAccessBloc>().add(LocationAccessUnavailableEvent());
      if (!_serviceEnabled) {
        context.read<LocationAccessBloc>().add(LocationAccessAvailableEvent());
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      context.read<LocationAccessBloc>().add(LocationAccessUnavailableEvent());
      if (_permissionGranted != PermissionStatus.granted) {
        context.read<LocationAccessBloc>().add(LocationAccessAvailableEvent());
        return;
      }
    }

    _locationData = await location.getLocation().then((value) {
      context.read<LocationDataBloc>().add(LocationDataUpdateEvent(value));
      return value;
    });
  }
}