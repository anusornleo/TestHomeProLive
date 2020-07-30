import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:test_live_app/pages/LivePage.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'video_list.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: RaisedButton(
            child: Text("View Live"),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => LivePage()));
            },
          ),
        ),
      ),
    );
  }
}
