import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forecaster/bloc/forecasts_data_bloc/forecasts_data_bloc.dart';
import 'package:intl/intl.dart';

class WeatherInHourWidget extends StatelessWidget {
  WeatherInHourWidget({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    var state = context.read<ForecastsDataBloc>().state;
    return Row(
      children: [
        const Icon(
          Icons.wb_cloudy,
          size: 50,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width / 7,
        ),
        Column(
          children:  [
            Text(DateFormat('HH:mm').format(DateTime.fromMillisecondsSinceEpoch(state.list[index].dt* 1000))),
            Text(state.list[index].weather.first.description),
            Text("index $index"),
          ],
        ),
        Spacer(),
         Text(
           state.list[index].main.temp.toInt().round().toString(),
          style: const TextStyle(color: Colors.lightBlue, fontSize: 30),
        )
      ],
    );
  }
}
