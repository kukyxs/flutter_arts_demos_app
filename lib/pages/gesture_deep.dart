import 'package:flutter/material.dart';

class GestureDeepened extends StatefulWidget {
  @override
  _GestureDeepenedState createState() => _GestureDeepenedState();
}

class _GestureDeepenedState extends State<GestureDeepened> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  double _touchY, _touchX;
  double _scale = 1.0;
  Tween<double> _scaleVale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    _scaleVale = Tween(begin: 1.0, end: 1 / 2);
    _scaleVale.chain(CurveTween(curve: Curves.decelerate));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    print('width: $width');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: <Widget>[
            ScaleTransition(
              scale: _scaleVale.animate(_controller),
              child: Container(
                width: width * (_scale == 1.0 ? 1.0 : 1.0 - _scale),
                height: height * (_scale == 1.0 ? 1.0 : 1.0 - _scale) * 0.85,
                child: Image.asset(
                  'images/lm.jpg',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 40.0,
          ),
          onPanDown: (detail) {
            if (_controller.isCompleted) {
              _controller.reverse();
            }

            setState(() {
              _touchX = detail.globalPosition.dx;
              _touchY = detail.globalPosition.dy;
              _scale = 1.0;
            });
          },
          onPanUpdate: (detail) {
            var deltaX = detail.globalPosition.dx - _touchX;
            var deltaY = detail.globalPosition.dy - _touchY;
            var absY = deltaY < 0 ? -deltaY : deltaY;
            var absX = deltaX < 0 ? -deltaX : deltaX;

            if (deltaY > 0) {
              setState(() {
                _scale = 1.0;
              });
            } else {
              var delta = absY.clamp(0, MediaQuery.of(context).size.height / 2);
              setState(() {
                _scale = delta / MediaQuery.of(context).size.height;
              });
            }
          },
          onPanCancel: () {
            setState(() {
              _scale = 1.0;
            });
          },
          onPanEnd: (details) {
            print('drag end: ${details.velocity}');
            if (_scale < 0.15) {
              _scaleVale.end = 1 / (1 - _scale);
            } else {
              _scaleVale.begin = _scale.clamp(1 / 2, 1.0);
            }
            print('dismissed: ${_controller.isDismissed}, completed: ${_controller.isCompleted}');
            if (_controller.isDismissed) {
              _controller.forward();
            }
          },
        ),
      ),
    );
  }
}
