import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StackDemoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          CircleAvatar(backgroundImage: AssetImage('images/ali.jpg'), radius: 100.0),
          Text(
            'Kuky',
            style: TextStyle(color: Colors.white, fontSize: 34.0),
          ),
          Positioned(child: Text('另外一段文字', style: TextStyle(color: Colors.white, fontSize: 20.0)), bottom: 10.0),
        ],
      )),
    );
  }
}
