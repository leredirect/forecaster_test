import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forecaster/bloc/current_weather_data_bloc/current_weather_data_bloc.dart';
import 'package:forecaster/utils/utils.dart';
import 'package:forecaster/widgets/today_briefly_widget.dart';
import 'package:forecaster/widgets/today_details_widget.dart';
import 'package:share/share.dart';

class TodayScreen extends StatefulWidget {
  const TodayScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TodayScreenState();
}

class _TodayScreenState extends State<TodayScreen> {
  bool _isLoaded = false;

  @override
  void initState() {
    super.initState();
    _isLoaded = true;
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await Utils.responseTransformer(context);
      },
      displacement: 40,
      child: CustomScrollView(slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 2,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.topRight,
                      colors: [
                        Colors.red,
                        Colors.orange,
                        Colors.yellow,
                        Colors.grey,
                        Colors.blue,
                        Colors.indigo,
                        Colors.pink
                      ]),
                ),
              ),
              Spacer(),
              TodayBrieflyWidget(),
              Spacer(),
              Container(
                height: 1,
                width: MediaQuery.of(context).size.width / 2,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                ),
              ),
              Spacer(),
              TodayDetailsWidget(),
              Spacer(),
              Container(
                height: 1,
                width: MediaQuery.of(context).size.width / 2,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                ),
              ),
              Spacer(),
              TextButton(
                  onPressed: () {
                    Share.share('Current weather in ' +
                        context.read<CurrentWeatherDataBloc>().state.name +
                        ":\nTemperature: " +
                        context
                            .read<CurrentWeatherDataBloc>()
                            .state
                            .main
                            .temp
                            .toInt()
                            .toString() +
                        "C°, " +
                        context
                            .read<CurrentWeatherDataBloc>()
                            .state
                            .weather
                            .first
                            .description);
                  },
                  child: const Text(
                    "Share",
                    style: TextStyle(color: Colors.red, fontSize: 17),
                  )),
              Spacer(),
            ],
          ),
        ),
      ]),
    );
  }
}
