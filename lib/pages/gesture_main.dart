import 'package:flutter/material.dart';

class GestureDemoPage extends StatefulWidget {
  @override
  _GestureDemoPageState createState() => _GestureDemoPageState();
}

class _GestureDemoPageState extends State<GestureDemoPage> {
  double left = 0.0;
  double top = 0.0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Gesture Demo'),
        ),
        body: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(child: Container(width: 50.0, height: 50.0, color: Colors.red), left: left, top: top),
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              child: Container(
                  color: Colors.transparent,
                  width: MediaQuery.of(context).size.width - 10,
                  height: MediaQuery.of(context).size.height),
              onPanDown: (details) {
                setState(() {
                  left = details.globalPosition.dx;
                  top = details.globalPosition.dy;
                });
              },
              onPanUpdate: (details) {
                setState(() {
                  left = details.globalPosition.dx;
                  top = details.globalPosition.dy;
                });
              },
              onPanCancel: () {
                setState(() {
                  left = 0.0;
                  top = 0.0;
                });
              },
              onPanEnd: (details) {
                setState(() {
                  left = 0.0;
                  top = 0.0;
                });
              },

              onScaleUpdate: (details){
                print(details.scale);
              },
            )
          ],
        ));
  }
}
