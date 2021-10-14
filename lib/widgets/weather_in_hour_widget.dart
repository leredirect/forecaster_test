import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WeatherInHourWidget extends StatelessWidget {
  const WeatherInHourWidget({Key? key}) : super(key: key);

  final int index = 1;

  @override
  Widget build(BuildContext context) {
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
          children: const [
            Text("time"),
            Text("forecast"),
          ],
        ),
        Spacer(),
        const Text(
          "20",
          style: TextStyle(color: Colors.lightBlue, fontSize: 30),
        )
      ],
    );
  }
}
