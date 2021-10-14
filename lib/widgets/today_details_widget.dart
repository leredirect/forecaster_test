import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TodayDetailsWidget extends StatelessWidget {
  const TodayDetailsWidget({Key? key}) : super(key: key);

  final int index = 1;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.all(10),
              child: Column(children: const [
                Icon(
                  Icons.wb_sunny_sharp,
                ),
                Text("fallout"),
              ]),
            ),
            Container(
                margin: EdgeInsets.all(10),
              child: Column(children: const [
                Icon(
                  Icons.wb_sunny_sharp,
                ),
                Text("humidity"),
              ]),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: Column(children: const [
                Icon(
                  Icons.wb_sunny_sharp,
                ),
                Text("pressure"),
              ]),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.all(10),
              child: Column(children: const [
                Icon(
                  Icons.wb_sunny_sharp,
                ),
                Text("wind speed"),
              ]),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: Column(children: const [
                Icon(
                  Icons.wb_sunny_sharp,
                ),
                Text("wind direction"),
              ]),
            ),
          ],
        ),
      ],
    );
  }
}
