import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forecaster/widgets/weather_in_hour_widget.dart';

class DayScheduleListWidget extends StatelessWidget {
  const DayScheduleListWidget({Key? key}) : super(key: key);

  final int index = 1;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (BuildContext context, index) {
        return Column(
          children: [
            Container(
              child: const Text("Day"),
              margin: const EdgeInsets.only(top: 5),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 20,
            ),
            ListView.builder(
              physics: const ClampingScrollPhysics(),
              shrinkWrap: true,
              itemCount: 5,
              itemBuilder: (BuildContext context, index) {
                return Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  margin: const EdgeInsets.only(top: 5),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 12,
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.black)),
                  child: const WeatherInHourWidget(),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
