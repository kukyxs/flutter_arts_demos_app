import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class CustomViewDemoPage extends StatefulWidget {
  @override
  _CustomViewDemoPageState createState() => _CustomViewDemoPageState();
}

class _CustomViewDemoPageState extends State<CustomViewDemoPage> with SingleTickerProviderStateMixin {
  AnimationController _animController;
  Animation<double> _radiusAnimation;
  Animation<Color> _colorAnimation;

  @override
  void initState() {
    super.initState();

    _animController = AnimationController(vsync: this, duration: Duration(milliseconds: 3000));
    _radiusAnimation = Tween(begin: 0.0, end: 100.0).chain(CurveTween(curve: Curves.decelerate)).animate(_animController);
    _colorAnimation = ColorTween(begin: Colors.red[300], end: Colors.red[900]).chain(CurveTween(curve: Curves.ease)).animate(_animController);

//    _animController.addListener(() {
//      setState(() {});
//    });

//    _animController.addStatusListener((status) {
//      if (status == AnimationStatus.completed) {
//        _animController.reverse();
//      } else if (status == AnimationStatus.dismissed) {
//        _animController.forward();
//      }
//    });
//
//    _animController.forward();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CustomView Demo'),
      ),
      body: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: CustomPaint(
//          painter: AnimatedCirclePainter(_radiusAnimation.value, _colorAnimation.value),
//          painter: LoveView(),
//          painter: LabelViewPainter(labelWidth: 100.0, useAngle: false, alignment: LabelAlignment.bottomRight),
          painter: LabelTextPainter('HOT'),
          size: MediaQuery.of(context).size,
        ),
      ),
    );
  }
}

enum LabelAlignment { topLeft, topRight, bottomLeft, bottomRight }

class LabelTextPainter extends CustomPainter {
  final double labelWidth;
  final String labelText;
  final TextStyle labelTextStyle;
  final LabelAlignment alignment;

  var _textPainter = TextPainter();

  LabelTextPainter(this.labelText, {this.labelWidth = 100.0, this.labelTextStyle, this.alignment = LabelAlignment.topLeft})
      : assert(labelWidth != null && labelWidth >= 50.0),
        assert(labelText != null),
        assert(alignment != null);

  @override
  void paint(Canvas canvas, Size size) {
    double rotateAngle;

    _textPainter
      ..text = TextSpan(style: labelTextStyle ?? TextStyle(color: Colors.black, fontSize: 14.0), text: labelText)
      ..textDirection = TextDirection.ltr;

    switch (alignment) {
      case LabelAlignment.topLeft:
        rotateAngle = -pi / 4;
        break;
      case LabelAlignment.topRight:
        rotateAngle = pi / 4;
        break;
      case LabelAlignment.bottomLeft:
        rotateAngle = pi / 4;
        break;
      case LabelAlignment.bottomRight:
        rotateAngle = -pi / 4;
        break;
    }

    canvas.save();
    canvas.translate(labelWidth, labelWidth);
    canvas.rotate(rotateAngle);
    _textPainter.layout(maxWidth: size.width);
    _textPainter.paint(canvas, Offset(0, 0));
    canvas.restore();
  }

  @override
  bool shouldRepaint(LabelTextPainter oldDelegate) {
    return false;
  }
}

class LabelViewPainter extends CustomPainter {
  final double labelWidth;
  final LabelAlignment alignment;
  final bool useAngle;
  final Color labelColor;
  final double showPart;

  var _labelPaint = Paint()..isAntiAlias = true;
  var _labelOutPath = Path();

  LabelViewPainter(
      {this.labelWidth = 100.0, this.alignment = LabelAlignment.topLeft, this.useAngle = true, this.labelColor = Colors.red, this.showPart = 0.6})
      : assert(labelWidth != null && labelWidth >= 50.0),
        assert(alignment != null),
        assert(useAngle != null),
        assert(labelColor != null),
        assert(showPart <= 1.0 && showPart >= 0.6);

  @override
  void paint(Canvas canvas, Size size) {
    _labelPaint..color = labelColor;

    switch (alignment) {
      case LabelAlignment.topLeft:
        if (useAngle) {
          _labelOutPath.moveTo(.0, .0);
          _labelOutPath.lineTo(labelWidth, 0);
          _labelOutPath.lineTo(0, labelWidth);
          _labelOutPath.close();
        } else {
          _labelOutPath.moveTo(labelWidth * (1 - showPart), .0);
          _labelOutPath.lineTo(labelWidth, .0);
          _labelOutPath.lineTo(.0, labelWidth);
          _labelOutPath.lineTo(0, labelWidth * (1 - showPart));
          _labelOutPath.close();
        }
        break;
      case LabelAlignment.topRight:
        if (useAngle) {
          _labelOutPath.moveTo(size.width, .0);
          _labelOutPath.lineTo(size.width - labelWidth, .0);
          _labelOutPath.lineTo(size.width, labelWidth);
          _labelOutPath.close();
        } else {
          _labelOutPath.moveTo(size.width - labelWidth * (1 - showPart), .0);
          _labelOutPath.lineTo(size.width - labelWidth, .0);
          _labelOutPath.lineTo(size.width, labelWidth);
          _labelOutPath.lineTo(size.width, labelWidth * (1 - showPart));
          _labelOutPath.close();
        }
        break;
      case LabelAlignment.bottomLeft:
        if (useAngle) {
          _labelOutPath.moveTo(.0, size.height);
          _labelOutPath.lineTo(labelWidth, size.height);
          _labelOutPath.lineTo(0, size.height - labelWidth);
          _labelOutPath.close();
        } else {
          _labelOutPath.moveTo(labelWidth * (1 - showPart), size.height);
          _labelOutPath.lineTo(labelWidth, size.height);
          _labelOutPath.lineTo(.0, size.height - labelWidth);
          _labelOutPath.lineTo(0, size.height - labelWidth * (1 - showPart));
          _labelOutPath.close();
        }
        break;
      case LabelAlignment.bottomRight:
        if (useAngle) {
          _labelOutPath.moveTo(size.width, size.height);
          _labelOutPath.lineTo(size.width - labelWidth, size.height);
          _labelOutPath.lineTo(size.width, size.height - labelWidth);
          _labelOutPath.close();
        } else {
          _labelOutPath.moveTo(size.width - labelWidth * (1 - showPart), size.height);
          _labelOutPath.lineTo(size.width - labelWidth, size.height);
          _labelOutPath.lineTo(size.width, size.height - labelWidth);
          _labelOutPath.lineTo(size.width, size.height - labelWidth * (1 - showPart));
          _labelOutPath.close();
        }
        break;
    }

    canvas.drawPath(_labelOutPath, _labelPaint);
  }

  @override
  bool shouldRepaint(LabelViewPainter oldDelegate) {
    return false;
  }
}

class AnimatedCirclePainter extends CustomPainter {
  final double radius;
  final Color color;

  Paint _paint;

  AnimatedCirclePainter(this.radius, this.color) {
    _paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..isAntiAlias = true
      ..strokeWidth = 1.0;
  }

  @override
  void paint(Canvas canvas, Size size) {
    var width = size.width;
    var height = size.height;
    canvas.drawCircle(Offset(width / 2, height / 2), radius, _paint);
  }

  @override
  bool shouldRepaint(AnimatedCirclePainter oldDelegate) {
    return oldDelegate.radius != radius || oldDelegate.color != color;
  }
}

class LoveView extends CustomPainter {
  final _paint = Paint()
    ..color = Colors.red
    ..style = PaintingStyle.stroke
    ..isAntiAlias = true
    ..strokeWidth = 2.0
    ..strokeCap = StrokeCap.round;

  @override
  void paint(Canvas canvas, Size size) {
//    final path = Path()..addRect(Rect.fromCircle(center: Offset(size.width / 2, size.height / 2), radius: min(size.width, size.height) / 2 - 10));
    final pLeft = Path()
      ..moveTo(size.width / 2, size.height / 4)
      ..cubicTo(size.width / 7, size.height / 9, size.width / 13, (size.height * 2) / 5, size.width / 2, (size.height * 7) / 12)
      ..cubicTo(size.width * 12 / 13, (size.height * 2) / 5, size.width * 6 / 7, size.height / 9, size.width / 2, size.height / 4);

    canvas.drawPath(pLeft, _paint);
  }

  @override
  bool shouldRepaint(LoveView oldDelegate) {
    return false;
  }
}
