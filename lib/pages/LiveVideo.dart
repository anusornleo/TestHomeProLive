import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class LiveVideo extends StatefulWidget {
  @override
  _LiveVideoState createState() => _LiveVideoState();
}

class _LiveVideoState extends State<LiveVideo> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  YoutubePlayerController _controller;

  PlayerState _playerState;
  YoutubeMetaData _videoMetaData;
  double _volume = 100;
  bool _muted = false;
  bool _isPlayerReady = false;
  bool _isEnd = false;

//  String url = "https://www.youtube.com/watch?v=m9h12tuUqGo"; // vertical video
  String url = "https://www.youtube.com/watch?v=9pieilNMWHY"; // live video

  @override
  void initState() {
    super.initState();
    String id = YoutubePlayer.convertUrlToId(url);
    _controller = YoutubePlayerController(
      initialVideoId: id,
      flags: YoutubePlayerFlags(
          hideControls: true,
          hideThumbnail: true,
          autoPlay: true,
          enableCaption: false,
          isLive: false,
          disableDragSeek: true),
    )..addListener(listener);
  }

  void listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {
        _playerState = _controller.value.playerState;
        _videoMetaData = _controller.metadata;
      });
    }
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

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      onExitFullScreen: () {
        SystemChrome.setPreferredOrientations(DeviceOrientation.values);
      },
      player: YoutubePlayer(
        bufferIndicator: Center(
          child: Text(
            "Loading...",
            style: TextStyle(color: Colors.white),
          ),
        ),
        aspectRatio: 9 / 16,
        controller: _controller,
        showVideoProgressIndicator: false,
        bottomActions: [
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              "HomePro Live",
              style: const TextStyle(
                color: Colors.blue,
                fontSize: 18.0,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          IconButton(
            icon: Icon(_muted ? Icons.volume_off : Icons.volume_up),
            onPressed: _isPlayerReady
                ? () {
                    _muted ? _controller.unMute() : _controller.mute();
                    setState(() {
                      _muted = !_muted;
                    });
                  }
                : null,
          ),
        ],
        onReady: () {
          print("Ready...");
          _isPlayerReady = true;
        },
        onEnded: (data) {
          setState(() {
            _isEnd = true;
          });
        },
      ),
      builder: (context, player) => Scaffold(
        key: _scaffoldKey,
        body: _customPlayer(player),
      ),
    );
  }

  Widget _customPlayer(player) {
    return Stack(
      children: [
        player,
        Text(
          _playerState.toString(),
          style: TextStyle(color: Colors.white),
        ),
        _isEnd ? _endLive() : Container()
      ],
    );
  }

  Widget _endLive() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.red,
      child: Center(
        child: Text("End Live..."),
      ),
    );
  }
}
