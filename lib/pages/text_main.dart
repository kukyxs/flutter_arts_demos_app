import 'package:flutter/material.dart';

class TextDemoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Text Demo Page')),
        body: Container(
          padding: const EdgeInsets.only(top: 10.0),
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('绿色背景黑色文字展示',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 24.0,
                      letterSpacing: 2.0,
                      background: Paint()..color = Colors.green)),
              Text('这是一个带红色下划线的文字展示',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 24.0,
                      decoration: TextDecoration.underline,
                      decorationStyle: TextDecorationStyle.solid,
                      decorationColor: Colors.red))
            ],
          )),
        ));
  }
}
