import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forecaster/bloc/forecasts_data_bloc/forecasts_data_bloc.dart';
import 'package:forecaster/widgets/weather_in_hour_widget.dart';
import 'package:intl/intl.dart';

class DayScheduleListWidget extends StatelessWidget {
  const DayScheduleListWidget({Key? key}) : super(key: key);

  final int index = 1;

  @override
  Widget build(BuildContext context) {
    int indexToInnerIndex(int innerIndex, int index) {
      int result = 0;
      if (index == 0) {
        result = innerIndex;
      } else if (index == 1) {
        result = innerIndex + 8;
      } else if (index == 2) {
        result = innerIndex + 16;
      } else if (index == 3) {
        result = innerIndex + 24;
      } else if (index == 4) {
        result = innerIndex + 32;
      }
      return result;
    }

    return ListView.builder(
      itemCount: 5,
      itemBuilder: (BuildContext context, index) {
        return Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 5),
              child: Text(DateFormat('dd-MM-yyyy').format(DateTime.fromMillisecondsSinceEpoch(context.read<ForecastsDataBloc>().state.list[index == 0 ? 0 : (index * 8) - 1].dt * 1000))),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 20,
            ),
            ListView.builder(
              physics: const ClampingScrollPhysics(),
              shrinkWrap: true,
              itemCount: 8,
              itemBuilder: (BuildContext context, innerIndex) {
                return Container(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  margin: const EdgeInsets.only(top: 5),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 12,
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.black)),
                  child: DateTime.tryParse(context
                              .read<ForecastsDataBloc>()
                              .state
                              .list[indexToInnerIndex(innerIndex, index)]
                              .dt
                              .toString())!
                          .isAfter(DateTime.now())
                      ? WeatherInHourWidget(
                          index: indexToInnerIndex(innerIndex, index))
                      : Container(),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
