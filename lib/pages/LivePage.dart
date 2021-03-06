import 'package:flutter/material.dart';
import 'package:test_live_app/widgets/BackgroundLive.dart';
import 'package:test_live_app/widgets/ForegroundLive.dart';

class LivePage extends StatefulWidget {
  @override
  _LivePageState createState() => _LivePageState();
}

class _LivePageState extends State<LivePage> {
  String titleLive = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            BackgroundLive(
                url: "https://youtu.be/SCiMSkb62g8",
                callback: (val) {
                  setState(() {
                    titleLive = val;
                  });
                }),
            ForegroundLive(
              titleLive: titleLive,
            )
          ],
        ),
      ),
    );
  }
}
