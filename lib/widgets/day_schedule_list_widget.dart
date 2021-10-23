import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forecaster/bloc/forecasts_data_bloc/forecasts_data_bloc.dart';
import 'package:forecaster/consts.dart';
import 'package:forecaster/utils/utils.dart';
import 'package:forecaster/widgets/weather_in_hour_widget.dart';
import 'package:intl/intl.dart';

class DayScheduleListWidget extends StatelessWidget {
  DayScheduleListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int indexToInnerIndex(int innerIndex, int index, int firstDayLength) {
      int result = 0;
      if (index == 0) {
        result = innerIndex;
      } else if (index == 1) {
        result = innerIndex + firstDayLength;
      } else if (index == 2) {
        result = innerIndex + firstDayLength + 8;
      } else if (index == 3) {
        result = innerIndex + firstDayLength + 16;
      } else if (index == 4) {
        result = innerIndex + firstDayLength + 24;
      }
      return result;
    }

    int itemCount(int index) {
      List result = context
          .read<ForecastsDataBloc>()
          .state
          .list
          .where((element) =>
              DateTime.fromMillisecondsSinceEpoch(element.dt * 1000).day ==
              DateTime.now().day)
          .toList();
      if (index == 0) {
        return result.length;
      } else {
        return 8;
      }
    }

    return Column(
      children: [
        Container(
          height: 2,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.topRight,
                colors: [Colors.red, Colors.orange, Colors.yellow, Colors.grey, Colors.blue, Colors.indigo, Colors.pink]
            ),
          ),
        ),
        Expanded(
          child: RefreshIndicator(
            onRefresh: () async {
              await Utils.responseTransformer(context);
            },
            displacement: 40,
            child: ListView.builder(
              //shrinkWrap: true,
              itemCount: 5,
              itemBuilder: (BuildContext context, index) {
                if (itemCount(index) == 0) {
                  return Container();
                } else {
                  return Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 10),
                        margin: const EdgeInsets.only(top: 10, bottom: 10),
                        child: Text(
                          index == 0
                              ? "TODAY"
                              : DateFormat('EEEE')
                                  .format(DateTime.fromMillisecondsSinceEpoch(context
                                          .read<ForecastsDataBloc>()
                                          .state
                                          .list[index == 0 ? 0 : (index * 8) - 1]
                                          .dt *
                                      1000))
                                  .toUpperCase(),
                          style: mediumText,
                        ),
                        width: MediaQuery.of(context).size.width,
                        //height: MediaQuery.of(context).size.height / 26,
                      ),
                      ListView.builder(
                        physics: const ClampingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: itemCount(index),
                        itemBuilder: (BuildContext context, innerIndex) {
                          return Container(
                              padding: const EdgeInsets.only(left: 10, right: 10),
                              //margin: const EdgeInsets.only(top: 5),
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height / 12,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: index == 0 ? Colors.blue : Colors.white)),
                              child: WeatherInHourWidget(
                                  index: indexToInnerIndex(
                                      innerIndex, index, itemCount(0))));
                        },
                      ),
                    ],
                  );
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
