import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forecaster/widgets/day_schedule_list_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forecaster/bloc/forecasts_data_bloc/forecasts_data_bloc.dart';

class ForecastScreen extends StatefulWidget {
  final String cityName;
  const ForecastScreen({Key? key, required this.cityName}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ForecastScreenState();
}

class _ForecastScreenState extends State<ForecastScreen> {
  @override
  Widget build(BuildContext context) {
    return DayScheduleListWidget();
  }
}
