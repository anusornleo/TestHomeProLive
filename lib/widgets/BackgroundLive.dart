import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'dart:math' as math;

typedef void StringCallback(String val);

class BackgroundLive extends StatefulWidget {
  final String url;
  final StringCallback callback;

  BackgroundLive({this.url, this.callback});

  @override
  _BackgroundLiveState createState() => _BackgroundLiveState();
}

class _BackgroundLiveState extends State<BackgroundLive> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  YoutubePlayerController _controller;
  YoutubeMetaData _metaData;
  PlayerState _playerState;
  bool _muted = false;
  bool _isPlayerReady = false;
  bool _isEnd = false;

  @override
  void initState() {
    super.initState();
    String id = YoutubePlayer.convertUrlToId(widget.url);
    _controller = YoutubePlayerController(
        initialVideoId: id,
        flags: YoutubePlayerFlags(
//            startAt: 175,
            hideControls: true,
            autoPlay: true,
            enableCaption: false,
            disableDragSeek: true))
      ..addListener(listener);
    _metaData = YoutubeMetaData();
  }

  void listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {
        _playerState = _controller.value.playerState;
        _metaData = _controller.metadata;
        if (_metaData.title.length != 0) {
          widget.callback(_metaData.title);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    double ratio = w / h;
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        bufferIndicator: Center(
          child: Text(
            "Loading...",
            style: TextStyle(color: Colors.green),
          ),
        ),
        width: 900,
        controller: _controller,
        aspectRatio: ratio,
        showVideoProgressIndicator: false,
        onReady: () {
          _isPlayerReady = true;
        },
        onEnded: (data) {
          setState(() {
            _isEnd = true;
          });
        },
      ),
      builder: (context, player) {
        return Scaffold(
          key: _scaffoldKey,
          backgroundColor: Colors.orange,
          body: SingleChildScrollView(
            child: Stack(
              children: [
//                Transform.rotate(
//                  angle: -math.pi / 2,
//                  child: player,
//                ),
                player,
                _playerState == PlayerState.playing ||
                        _playerState == PlayerState.ended
                    ? Container()
                    : _startScreen(),
                _isEnd ? _endScreen() : Container(),
//                _isPlayerReady ? Container() : _endScreen(),
//                Align(
//                  alignment: Alignment.topCenter,
//                  child: Text(
//                    _playerState.toString(),
//                    style: TextStyle(color: Colors.blue),
//                  ),
//                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _endScreen() {
    return Container(
      height: MediaQuery.of(context).size.height,
      color: Colors.blueGrey,
      child: Center(
        child: Text("End Video"),
      ),
    );
  }

  Widget _startScreen() {
    return Container(
      height: MediaQuery.of(context).size.height,
      color: Colors.black,
      child: Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.indigo,
        ),
      ),
    );
  }

  @override
  void deactivate() {
    super.deactivate();
    _controller.pause();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
