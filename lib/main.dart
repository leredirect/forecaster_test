import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forecaster/screens/home_screen.dart';
import 'package:forecaster/utils/utils.dart';
import 'package:location/location.dart';

import 'bloc/connectivity_bloc/connectivity_bloc.dart';
import 'bloc/connectivity_bloc/connectivity_event.dart';
import 'bloc/current_weather_data_bloc/current_weather_data_bloc.dart';
import 'bloc/forecasts_data_bloc/forecasts_data_bloc.dart';
import 'bloc/location_access_bloc/location_access_bloc.dart';
import 'bloc/location_access_bloc/location_access_event.dart';
import 'bloc/location_data_bloc/location_data_bloc.dart';
import 'bloc/location_data_bloc/location_data_event.dart';

void main() {
  runApp(MultiBlocProvider(providers: [
    BlocProvider<ConnectivityBloc>(create: (context) => ConnectivityBloc()),
    BlocProvider<LocationAccessBloc>(create: (context) => LocationAccessBloc()),
    BlocProvider<LocationDataBloc>(create: (context) => LocationDataBloc()),
    BlocProvider<CurrentWeatherDataBloc>(create: (context) => CurrentWeatherDataBloc()),
    BlocProvider<ForecastsDataBloc>(create: (context) => ForecastsDataBloc()),
  ], child: const ForecasterApp(key: Key("key"))));
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

    print("DCD_MAIN++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");

    await Utils.fetchLocation(context);

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
