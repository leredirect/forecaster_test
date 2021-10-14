import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forecaster/screens/home_screen.dart';


void main() {
  runApp(const ForecasterApp(key: Key("key")));
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
          primarySwatch: Colors.yellow,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }
}
