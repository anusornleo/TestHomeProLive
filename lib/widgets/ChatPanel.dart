import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'MessageShow.dart';

class ChatPanel extends StatefulWidget {
  @override
  _ChatPanelState createState() => _ChatPanelState();
}

class _ChatPanelState extends State<ChatPanel> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ShaderMask(
        shaderCallback: (rect) {
          return LinearGradient(
            begin: Alignment.bottomRight,
            end: Alignment.topRight,
            colors: [
              Colors.black,
              Colors.black,
              Colors.black,
              Colors.black,
              Colors.black,
              Colors.transparent
            ],
          ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
        },
        blendMode: BlendMode.dstIn,
        child: _chatSnapshot(),
      ),
    );
  }

  Widget _chatSnapshot() {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection("chat").orderBy("time",descending: true).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Text("Wait...");
        } else {
          return ListView.builder(
            reverse: true,
            physics: BouncingScrollPhysics(),
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index) {
              DocumentSnapshot data = snapshot.data.documents[index];
              return MessageShow(
                name: data['user'],
                message: data['message'],
              );
            },
          );
//        return Text(snapshot.data.documents.toString());
        }
      },
    );
  }
}
