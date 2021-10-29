import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forecaster/bloc/current_weather_data_bloc/current_weather_data_bloc.dart';
import 'package:forecaster/bloc/current_weather_data_bloc/current_weather_state.dart';
import 'package:forecaster/utils/utils.dart';
import 'package:forecaster/widgets/loading_widget.dart';
import 'package:forecaster/widgets/today_briefly_widget.dart';
import 'package:forecaster/widgets/today_details_widget.dart';
import 'package:share/share.dart';

import '../constants.dart';

class TodayScreen extends StatefulWidget {
  const TodayScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TodayScreenState();
}

class _TodayScreenState extends State<TodayScreen> {
  @override
  Widget build(BuildContext context) {
    Widget buildBorderWidget() {
      return Container(
        height: 1,
        width: MediaQuery.of(context).size.width / 2,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
        ),
      );
    }

    Widget buildTodayScreenLayout(CurrentWeatherDataState state) {
      return Scaffold(
        backgroundColor: mainBackgroundColor,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: secondaryBackgroundColor,
          title: const Text(
            "Today",
            style: bigText,
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            await Utils.currentWeatherResponseTransformer(context);
          },
          displacement: 5,
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
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.topRight,
                          colors: [
                            Colors.pink,
                            Colors.blue,
                            Colors.indigo,
                            Colors.pink
                          ]),
                    ),
                  ),
                  const Spacer(),
                  TodayBrieflyWidget(
                    currentWeather: state.currentWeather,
                  ),
                  const Spacer(),
                  buildBorderWidget(),
                  const Spacer(),
                  TodayDetailsWidget(currentWeather: state.currentWeather),
                  const Spacer(),
                  buildBorderWidget(),
                  const Spacer(),
                  TextButton(
                      onPressed: () {
                        Share.share('Current weather in ' +
                            state.currentWeather.name +
                            ":\nTemperature: " +
                            state.currentWeather.currentBaseInfo.temp
                                .toInt()
                                .toString() +
                            "C°, " +
                            state.currentWeather.currentMetaInfo.first
                                .description);
                      },
                      child: const Text(
                        "Share",
                        style: TextStyle(color: Colors.red, fontSize: 17),
                      )),
                  const Spacer(),
                ],
              ),
            ),
          ]),
        ),
      );
    }

    return BlocBuilder<CurrentWeatherDataBloc, CurrentWeatherState>(
        builder: (context, state) {
      return AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          child: state is CurrentWeatherDataState
              ? buildTodayScreenLayout(state)
              : const LoadingWidget());
    });
  }

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    await Utils.currentWeatherResponseTransformer(context);
  }
}
