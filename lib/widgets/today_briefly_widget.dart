import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forecaster/bloc/current_weather_data_bloc/current_weather_data_bloc.dart';
import 'package:forecaster/models/forecasts_list.dart';
import 'package:forecaster/res/fonts/forecaster_icons.dart';
import 'package:forecaster/utils/utils.dart';

import '../consts.dart';

class TodayBrieflyWidget extends StatelessWidget {
  const TodayBrieflyWidget({Key? key}) : super(key: key);

  //const TodayBrieflyWidget(CurrentWeather currentWeather, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    //CurrentWeather state = context.read<CurrentWeatherDataBloc>().state;
    return BlocBuilder<CurrentWeatherDataBloc, CurrentWeather>(
        builder: (context, state) {
          if (state.weather.isNotEmpty){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Utils.nameToIconMap[state.weather.first.icon], color: Colors.yellow.shade600, size: 120,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/6.5, bottom: 20),
                  child: Icon(
                    Icons.location_on_outlined,
                    size: 10, color: Colors.blue,
                  ),
                ),
              ),
              Container(margin: EdgeInsets.all(15),child: Text(state.name + ", " + state.currentSys.country,style: bigText,)),
              Spacer(),
            ],
          ),
          Text(state.main.temp.round().toString() +
              "C°" +
              " | " +
              state.weather.first.description.toString().toUpperCase(), style: blueBigText,),
        ],
      );
          }else{
            return Container();
          }
    });
  }
}
