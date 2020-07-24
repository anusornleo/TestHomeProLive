import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ForegroundLive extends StatefulWidget {
  String titleLive;

  ForegroundLive({this.titleLive});

  @override
  _ForegroundLiveState createState() => _ForegroundLiveState();
}

class _ForegroundLiveState extends State<ForegroundLive> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
//          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topRight,
                      colors: [Colors.black38, Colors.transparent])),
              child: SafeArea(
                child: Text(
                  widget.titleLive,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.red,
                  gradient: LinearGradient(
                      begin: Alignment.bottomRight,
                      colors: [
                        Colors.black26,
                        Colors.transparent,
                        Colors.transparent
                      ])),
              child: Column(
                children: [
                  Expanded(
                    child: Text("ddddd"),
                  ),
                  _bottomWidget(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Container _bottomWidget() {
    return Container(
      width: double.infinity,
      height: 62,
      color: Colors.green,
      child: Row(
        children: [_itemButton(), _chatField()],
      ),
    );
  }

  Widget _itemButton() {
    return new Container(
      width: 48.0,
      decoration: new BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.red,
      ),
      child: Center(child: Icon(Icons.delete)),
    );
  }

  Widget _chatField() {
    return Container(
      color: Colors.red,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            width: 200,
            height: 48,
            child: TextField(
              maxLength: 10,
              style: TextStyle(fontSize: 20),
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(left: 12),
                  hintText: "Try to type homepro",
                  hintStyle: TextStyle(color: Colors.grey[500]),
                  counterText: "",
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 2.0),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        width: 3,
                        color: Colors.blue,
                      ))),
            ),
          )
        ],
      ),
    );
  }
}
