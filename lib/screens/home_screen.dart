import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forecaster/bloc/current_weather_data_bloc/current_weather_data_bloc.dart';
import 'package:forecaster/models/forecasts_list.dart';
import 'package:forecaster/res/fonts/forecaster_icons.dart';
import 'package:forecaster/screens/today_screen.dart';
import 'package:forecaster/utils/utils.dart';

import 'forecast_screen.dart';

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
    print(
        "DCD_HS+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
    try {
      await Utils.responseTransformer(context);
    } on Exception catch (err) {
      print("Platform exception calling serviceEnabled(): $err ++++++++++++++");
      await Utils.responseTransformer(context);
    }
  }

  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    print("rebuild");
    return BlocBuilder<CurrentWeatherDataBloc, CurrentWeather>(
        builder: (context, state) {
      List<Widget> _elements = [
        const TodayScreen(),
        ForecastScreen(
          cityName: state.name,
        ),
      ];
      return AnimatedSwitcher(
          duration: const Duration(milliseconds: 1000),
          child: state.weather.isNotEmpty
              ?  Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: Text(_currentIndex == 0? "Today" : state.name),
              centerTitle: true,
              backgroundColor: Colors.white,
            ),
            body: PageView(
                    controller: _pageViewController,
                    children: <Widget>[
                      const TodayScreen(),
                      ForecastScreen(
                        cityName: state.name,
                      ),
                    ],
                    onPageChanged: (index) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                  ),
                  // _elements.elementAt(_currentIndex)

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
                    onTap: (index) {
                      _pageViewController.animateToPage(index,
                          duration: Duration(milliseconds: 200),
                          curve: Curves.bounceOut);
                    },
                  ),
                )
              : Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  color: Colors.white,
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
