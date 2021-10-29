import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forecaster/utils/forecaster_icons.dart';

import '../constants.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: mainBackgroundColor,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                ForecasterIcons.cloud_sun,
                size: 70,
                color: Colors.blue,
              ),
              Container(
                margin: const EdgeInsets.only(top: 30),
                height: 2,
                width: MediaQuery.of(context).size.width / 3,
                child: const LinearProgressIndicator(color: Colors.blue),
              ),
            ],
          ),
        ));
  }
}
