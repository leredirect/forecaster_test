import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:forecaster/screens/home_screen.dart';
import 'package:location/location.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/connectivity_bloc/connectivity_bloc.dart';
import 'bloc/connectivity_bloc/connectivity_event.dart';

void main() {
  runApp(MultiBlocProvider(
      providers: [
        BlocProvider<ConnectivityBloc>(
            create: (context) => ConnectivityBloc()),
      ],
      child: const ForecasterApp(key: Key("key"))));
}

class ForecasterApp extends StatefulWidget {
  const ForecasterApp({required Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ForecasterAppState();
}

class _ForecasterAppState extends State<ForecasterApp> {

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: MaterialApp(
        initialRoute: '/',
        title: 'Forecaster',
        routes: {
          '/': (context) => const SafeArea(child: HomeScreen()),
        },
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.lightBlue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
      ),
    );
  }

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();

    print("DCD+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");

    Location location = Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

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

    _locationData = await location.getLocation().then((value){
      print(value.latitude);
      print(value.longitude);
      return value;
    });

    Connectivity().checkConnectivity().then((value) {
      if (value == ConnectivityResult.none) {
        context.read<ConnectivityBloc>().add(OfflineEvent());
      } else {
        context.read<ConnectivityBloc>().add(OnlineEvent());
      }
    });
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        context.read<ConnectivityBloc>().add(OfflineEvent());
      } else {
        context.read<ConnectivityBloc>().add(OnlineEvent());
      }
    });
  }
}
