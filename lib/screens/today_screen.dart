import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forecaster/widgets/today_briefly_widget.dart';
import 'package:forecaster/widgets/today_details_widget.dart';

class TodayScreen extends StatefulWidget {
  const TodayScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TodayScreenState();
}

class _TodayScreenState extends State<TodayScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Today"),
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
        body: CustomScrollView(slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(),
                const TodayBrieflyWidget(),
                Spacer(),
                Container(
                  height: 1,
                  width: MediaQuery.of(context).size.width / 2,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                  ),
                ),
                Spacer(),
                TodayDetailsWidget(),
                Spacer(),
                Container(
                  height: 1,
                  width: MediaQuery.of(context).size.width / 2,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                  ),
                ),
                Spacer(),
                TextButton(
                    onPressed: () {},
                    child: const Text(
                      "SHARE",
                      style: TextStyle(color: Colors.red),
                    )),
                Spacer(),
              ],
            ),
          ),
        ]));
  }
}
