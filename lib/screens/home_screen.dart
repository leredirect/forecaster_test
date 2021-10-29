import 'package:flutter/material.dart';
import 'package:forecaster/screens/forecast_screen.dart';
import 'package:forecaster/screens/today_screen.dart';

import '../constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _pageViewController = PageController();
  int _currentIndex = 0;

  @override
  void dispose() {
    _pageViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainBackgroundColor,
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
        backgroundColor: secondaryBackgroundColor,
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
              //more
              duration: const Duration(milliseconds: 500),
              curve: Curves.ease);
        },
      ),
    );
  }
}
