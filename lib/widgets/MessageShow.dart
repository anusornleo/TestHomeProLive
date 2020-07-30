import 'package:flutter/material.dart';

class MessageShow extends StatelessWidget {
  final String name;
  final String message;

  const MessageShow({Key key, this.name, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 3.0),
      child: RichText(
        text: TextSpan(children: <TextSpan>[
          TextSpan(
            text: name,
            style: TextStyle(
              color: Colors.yellow,
              fontWeight: FontWeight.bold
            ),
          ),
          TextSpan(text: " : " + message)
        ]),
      ),
    );
  }
}
