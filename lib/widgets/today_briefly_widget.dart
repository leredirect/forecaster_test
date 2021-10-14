import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TodayBrieflyWidget extends StatelessWidget {
  const TodayBrieflyWidget({Key? key}) : super(key: key);

  final int index = 1;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.wb_sunny_sharp,
          size: 100,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(right: 15, bottom: 20),
                child: Icon(
              Icons.location_on,
              size: 10,
            )),
            Text("_CITY, _COUNTRY"),
          ],
        ),
        Text("_DEG | _WEATHER"),
      ],
    );
  }
}
