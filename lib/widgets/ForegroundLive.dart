import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test_live_app/widgets/ChatPanel.dart';

import 'BottomSheetProduct.dart';
import 'MessageShow.dart';

class ForegroundLive extends StatefulWidget {
  String titleLive;

  ForegroundLive({this.titleLive});

  @override
  _ForegroundLiveState createState() => _ForegroundLiveState();
}

class _ForegroundLiveState extends State<ForegroundLive> {
  bool _keyboardState = false;
  bool _showRealInput = false;
  String text = "";
  bool hideUI = true;
  final firestoreInstance = Firestore.instance;

  @override
  void initState() {
    super.initState();
    KeyboardVisibilityNotification().addNewListener(
      onChange: (bool visible) {
        setState(() {
          _keyboardState = visible;
          _showRealInput = visible;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Container(
            height: MediaQuery
                .of(context)
                .size
                .height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical:10),
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.yellow,
                    gradient: LinearGradient(
                      colors: [Colors.black38,Colors.transparent],
                      begin: Alignment.topRight
                    )
                  ),
                  child: SafeArea(
                    child: RichText(
                      text: TextSpan(
                          style: TextStyle(fontSize: 22),
                          children: [
                            TextSpan(text: widget.titleLive)
                          ]
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                Spacer(),
                Container(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height - 400,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Colors.transparent,
                      Colors.black26,
                      Colors.black38
                    ], begin: Alignment.topRight),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ChatPanel(),
                      _bottomWidget(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        _showRealInput
            ? Container(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: _realInput(),
          ),
        )
            : Container()
      ],
    );
  }

  Container _bottomWidget() {
    return Container(
      width: double.infinity,
      height: 62,
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          _itemButton(),
          SizedBox(
            width: 8,
          ),
          _chatFieldMock(),
          SizedBox(
            width: 8,
          ),
          _shearButton()
        ],
      ),
    );
  }

  Widget _itemButton() {
    return GestureDetector(
      onTap: () {
        _settingModalBottomSheet(context);
      },
      child: Container(
        width: 48.0,
        decoration: new BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.indigo,
        ),
        child: Center(
            child: Icon(
              Icons.menu,
              color: Colors.white,
            )),
      ),
    );
  }

  Widget _chatFieldMock() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _showRealInput = true;
          text = "";
        });
      },
      child: Container(
        width: MediaQuery
            .of(context)
            .size
            .width - 132,
        height: 62,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(width: 2, color: Colors.grey),
        ),
        child: Align(
          alignment: Alignment(-0.8, 0),
          child: Text(
            "Type to Ask",
            style: TextStyle(color: Colors.grey),
          ),
        ),
      ),
    );
  }

  Widget _realInput() {
    return Container(
      color: Colors.white,
      child: Row(
        children: [
          Container(
            width: MediaQuery
                .of(context)
                .size
                .width - 60,
            height: 60,
            padding: EdgeInsets.only(left: 8),
            child: TextField(
              autofocus: true,
              style: TextStyle(fontSize: 20),
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(left: 12),
                  hintText: "Type to Ask",
                  hintStyle: TextStyle(color: Colors.grey[500]),
                  counterText: "",
                  focusedBorder: UnderlineInputBorder()),
              onSubmitted: (text) {
                _sentMessage(text);
              },
              onChanged: (text) {
                setState(() {
                  this.text = text;
                });
              },
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.send,
              color: Colors.indigo,
            ),
            onPressed: () {
              FocusScope.of(context).unfocus();
              _sentMessage(text);
            },
          ),
        ],
      ),
    );
  }

  Widget _shearButton() {
    return Container(
      width: 48.0,
      decoration: new BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.indigo,
      ),
      child: Center(
          child: Icon(
            Icons.share,
            color: Colors.white,
          )),
    );
  }

  void _sentMessage(text) {
    Firestore.instance.collection("chat").add({
      "user": "john",
      "message": text,
      "time": FieldValue.serverTimestamp()
    });
  }

  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return BottomSheetProduct();
        });
  }

  @override
  void dispose() {
    super.dispose();
    KeyboardVisibilityNotification().dispose();
  }
}
