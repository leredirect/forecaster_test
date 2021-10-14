import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:forecaster/screens/today_screen.dart';

import 'forecast_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

int _currentIndex = 0;

class _HomeScreenState extends State<HomeScreen> {
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
      body: PageTransitionSwitcher(
        transitionBuilder: (child, primaryAnimation, secondaryAnimation) =>
            FadeThroughTransition(
          animation: primaryAnimation,
          secondaryAnimation: secondaryAnimation,
          child: child,
        ),
        child: _elements.elementAt(_currentIndex),
      ),
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
