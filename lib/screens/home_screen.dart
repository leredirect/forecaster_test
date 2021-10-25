import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forecaster/bloc/current_weather_data_bloc/current_weather_data_bloc.dart';
import 'package:forecaster/models/forecasts_list.dart';
import 'package:forecaster/res/fonts/forecaster_icons.dart';
import 'package:forecaster/screens/today_screen.dart';
import 'package:forecaster/utils/utils.dart';
import 'package:forecaster/screens/forecast_screen.dart';

import '../constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

final _pageViewController = PageController();
int _currentIndex = 0;

class _HomeScreenState extends State<HomeScreen> {
  @override
  void dispose() {
    _pageViewController.dispose();
    super.dispose();
  }

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
      await Utils.responseTransformer(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentWeatherDataBloc, CurrentWeather>(
        builder: (context, state) {
      return AnimatedSwitcher(
          duration: const Duration(milliseconds: 1000),
          child: state.weather.isNotEmpty
              ? Scaffold(
                  backgroundColor: mainBackgroundColor,
                  appBar: AppBar(
                    title: Text(
                      _currentIndex == 0 ? "Today" : state.name,
                      style: bigText,
                    ),
                    centerTitle: true,
                    backgroundColor: secondaryBackgroundColor,
                  ),
                  body: PageView(
                    controller: _pageViewController,
                    children: const <Widget>[
                      TodayScreen(),
                      ForecastScreen(),
                    ],
                    onPageChanged: (index) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                  ),
                  bottomNavigationBar: BottomNavigationBar(
                    unselectedItemColor: Colors.grey,
                    backgroundColor:secondaryBackgroundColor,
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
                    onTap: (index) {
                      _pageViewController.animateToPage(index,
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.bounceOut);
                    },
                  ),
                )
              : Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  color: mainBackgroundColor,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          ForecasterIcons.cloud_sun,
                          size: 70,
                          color: Colors.blue,
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 30),
                          height: 2,
                          width: MediaQuery.of(context).size.width / 3,
                          child:
                              const LinearProgressIndicator(color: Colors.blue),
                        ),
                      ],
                    ),
                  )));
    });
  }
}
