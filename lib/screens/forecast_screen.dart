import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forecaster/bloc/forecasts_data_bloc/forecasts_data_bloc.dart';
import 'package:forecaster/bloc/forecasts_data_bloc/forecasts_state.dart';
import 'package:forecaster/constants.dart';
import 'package:forecaster/utils/utils.dart';
import 'package:forecaster/widgets/day_forecast_widget.dart';
import 'package:forecaster/widgets/loading_widget.dart';

class ForecastScreen extends StatefulWidget {
  const ForecastScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ForecastScreenState();
}

class _ForecastScreenState extends State<ForecastScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForecastsDataBloc, ForecastState>(
        builder: (context, state) {
      Widget buildWeekForecastWidget(ForecastDataState state) {
        return Scaffold(
          backgroundColor: mainBackgroundColor,
          appBar: AppBar(
            backgroundColor: secondaryBackgroundColor,
            title: Text(state.forecastList.forecastLocationInfo.name,
                style: bigText),
            centerTitle: true,
          ),
          body: Column(
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
              Expanded(
                child: RefreshIndicator(
                  color: Colors.white,
                  backgroundColor: secondaryBackgroundColor,
                  onRefresh: () async {
                    await Utils.forecastsResponseTransformer(context);
                  },
                  displacement: 5,
                  child: ListView.builder(
                    itemCount: 5,
                    itemBuilder: (BuildContext context, index) {
                      if (Utils.listBuilderItemCount(
                              index, state.forecastList) ==
                          0) {
                        return Container();
                      } else {
                        return DayForecastWidget(
                          forecastList: state.forecastList,
                          index: index,
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      }

      return AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          child: state is ForecastDataState
              ? buildWeekForecastWidget(state)
              : const LoadingWidget());
    });
  }

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    await Utils.forecastsResponseTransformer(context);
  }
}
