import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

void main() => runApp(DemoApp());

class DemoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.lightBlue),
      home: HomePage(),
    );
  }
}


class HomePage extends StatelessWidget {
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
