import 'dart:convert';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forecaster/bloc/current_weather_data_bloc/current_weather_data_bloc.dart';
import 'package:forecaster/bloc/current_weather_data_bloc/current_weather_data_event.dart';
import 'package:forecaster/bloc/forecasts_data_bloc/forecasts_data_bloc.dart';
import 'package:forecaster/bloc/forecasts_data_bloc/forecasts_data_event.dart';
import 'package:forecaster/bloc/location_data_bloc/location_data_bloc.dart';
import 'package:forecaster/models/forecasts_list.dart';
import 'package:forecaster/screens/today_screen.dart';
import 'package:forecaster/utils/utils.dart';
import 'package:http/http.dart';

import 'forecast_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

int _currentIndex = 0;

class _HomeScreenState extends State<HomeScreen> {
  Future<void> responseTransformer() async {

    if (context.read<LocationDataBloc>().state.latitude == null &&
    context.read<LocationDataBloc>().state.longitude == null){
     await Utils.fetchLocation(context);
    }

    Response currentWeatherDataResponse = await CurrentWeather.fetchCurrentWeather(
        context.read<LocationDataBloc>().state.latitude ?? 0.0,
        context.read<LocationDataBloc>().state.longitude ?? 0.0);

    Response forecastsDataResponse = await ForecastsList.fetchForecasts(
        context.read<LocationDataBloc>().state.latitude ?? 0.0,
        context.read<LocationDataBloc>().state.longitude ?? 0.0);
    switch (forecastsDataResponse.statusCode & currentWeatherDataResponse.statusCode) {
      case 200:
        ForecastsList forecastsData = ForecastsList.fromJson(json.decode(forecastsDataResponse.body));
        context.read<ForecastsDataBloc>().add(ForecastsDataUpdateEvent(forecastsData));
        print('41');
        CurrentWeather currentWeatherData = CurrentWeather.fromJson(json.decode(currentWeatherDataResponse.body));
        context.read<CurrentWeatherDataBloc>().add(CurrentWeatherDataUpdateEvent(currentWeatherData));
        print('44');
        break;
      default:
        int statusCode = 0;
        if (currentWeatherDataResponse.statusCode != 200){
          statusCode = currentWeatherDataResponse.statusCode;
        }
        if (forecastsDataResponse.statusCode != 200){
          statusCode = currentWeatherDataResponse.statusCode;
        }
        Utils.showMyDialog(context, "Error", "Error code: HTTP $statusCode", "Retry", responseTransformer);
    }
  }

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    print("DCD_HS+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
    try {
      await responseTransformer();
    }on Exception catch (err) {
    print("Platform exception calling serviceEnabled(): $err ++++++++++++++");
    await responseTransformer();
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _elements = [
      const TodayScreen(),
      const ForecastScreen(),
    ];

    void changeTab(int index) {
      setState(() {
        _currentIndex = index;
      });
    }

    return Scaffold(
      body: BlocBuilder<ForecastsDataBloc, ForecastsList>(
          builder: (context, state) {
        if (state.list.isNotEmpty) {
          print("64");
          return RefreshIndicator(
            onRefresh: () async {
              await responseTransformer();
            },
            displacement: 40,
            child: PageTransitionSwitcher(
              transitionBuilder:
                  (child, primaryAnimation, secondaryAnimation) =>
                      FadeThroughTransition(
                        animation: primaryAnimation,
                        secondaryAnimation: secondaryAnimation,
                        child: child,
              ),
              child: _elements.elementAt(_currentIndex),
            ),
          );
        } else {
          print("81");
          return Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.white,
              child: const Center(
                child: SizedBox(
                  height: 50,
                  width: 50,
                  child: CircularProgressIndicator(color: Colors.blueGrey),
                ),
              ));
        }
      }),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        enableFeedback: true,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.wb_sunny,
              size: 27,
            ),
            label: "Today",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.wb_cloudy,
              size: 27,
            ),
            label: "Forecast",
          )
        ],
        currentIndex: _currentIndex,
        onTap: changeTab,
      ),
    );
  }
}
