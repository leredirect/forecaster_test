import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forecaster/bloc/forecasts_data_bloc/forecasts_data_bloc.dart';
import 'package:forecaster/constants.dart';
import 'package:forecaster/models/forecasts_list.dart';
import 'package:forecaster/utils/utils.dart';
import 'package:intl/intl.dart';

class WeatherInHourWidget extends StatelessWidget {
  const WeatherInHourWidget({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForecastsDataBloc, ForecastsList>(
        builder: (context, state) {
      return Table(
        defaultVerticalAlignment: TableCellVerticalAlignment.bottom,
        columnWidths: <int, TableColumnWidth>{
          0: FixedColumnWidth(MediaQuery.of(context).size.width / 15),
          1: FlexColumnWidth(),
          2: FixedColumnWidth(MediaQuery.of(context).size.width / 4)
        },
        children: [
          TableRow(children: [
            TableCell(
              child: Icon(
                Utils.nameToIconMap[state.list[index].weather.first.icon],
                color: Colors.blue.shade600,
                size: 50,
              ),
            ),
            TableCell(
              child: Container(
                margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width / 6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        DateFormat('HH:mm').format(
                            DateTime.fromMillisecondsSinceEpoch(
                                state.list[index].dt * 1000)),
                        style: mediumText),
                    Text(
                      state.list[index].weather.first.description,
                      style: mediumText,
                    ),
                  ],
                ),
              ),
            ),
            TableCell(
              child: Text(
                state.list[index].main.temp.toInt().round().toString() + "°",
                style: blueGiantBoldText,
                textAlign: TextAlign.end,
              ),
            )
          ]),
        ],
      );
    });
  }
}
