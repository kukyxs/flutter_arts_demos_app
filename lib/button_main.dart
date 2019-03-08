import 'package:flutter/material.dart';

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
      appBar: AppBar(),
      body: Container(
        padding: const EdgeInsets.only(top: 10.0),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              onPressed: () {
                print('This is a Rased Button can be clicked');
              },
              child: Text('Raised Enable'),
            ),
            RaisedButton(onPressed: null, child: Text('Raised Disable')),
            FlatButton(
              onPressed: () => print('This is a Flat Button can be clicker'),
              child: Text('Flat Enable'),
            ),
            FlatButton(onPressed: null, child: Text('Flat Disable')),
            IconButton(icon: Icon(Icons.android), onPressed: () {}),
            IconButton(icon: Icon(Icons.android), onPressed: null),
            MaterialButton(onPressed: () {}, child: Text('Material Enable')),
            MaterialButton(onPressed: null, child: Text('Material Disable')),
            OutlineButton(onPressed: () {}, child: Text('Outline Enable')),
            OutlineButton(onPressed: null, child: Text('Outline Enable')),
          ],
        )),
      ),
      floatingActionButton:
          FloatingActionButton.extended(onPressed: () {}, icon: Icon(Icons.android), label: Text('Android')),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
