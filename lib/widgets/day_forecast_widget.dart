import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forecaster/constants.dart';
import 'package:forecaster/models/forecasts_list.dart';
import 'package:forecaster/utils/utils.dart';
import 'package:forecaster/widgets/weather_in_hour_widget.dart';
import 'package:intl/intl.dart';

class DayForecastWidget extends StatelessWidget {
  const DayForecastWidget(
      {Key? key, required this.index, required this.forecastList})
      : super(key: key);
  final ForecastsList forecastList;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(left: 10),
          margin: const EdgeInsets.only(top: 10, bottom: 10),
          child: Text(
            index == 0
                ? "TODAY"
                : DateFormat('EEEE')
                    .format(DateTime.fromMillisecondsSinceEpoch(forecastList
                            .forecastBaseInfoList[
                                index == 0 ? 0 : (index * 8) - 1]
                            .dt *
                        1000))
                    .toUpperCase(),
            style: mediumText,
          ),
          width: MediaQuery.of(context).size.width,
        ),
        ListView.builder(
          physics: const ClampingScrollPhysics(),
          shrinkWrap: true,
          itemCount: Utils.listBuilderItemCount(index, forecastList),
          itemBuilder: (BuildContext context, innerIndex) {
            return Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 12,
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Utils.indexToInnerIndex(
                                    innerIndex,
                                    index,
                                    Utils.listBuilderItemCount(
                                        index, forecastList)) ==
                                0
                            ? Colors.blue
                            : mainBackgroundColor)),
                child: WeatherInHourWidget(
                  index: Utils.indexToInnerIndex(innerIndex, index,
                      Utils.listBuilderItemCount(0, forecastList)),
                  forecastList: forecastList,
                ));
          },
        ),
      ],
    );
  }
}
