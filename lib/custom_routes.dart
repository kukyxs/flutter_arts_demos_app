import 'package:flutter/material.dart';

class ScalePageRoute extends PageRouteBuilder {
  final Widget widget;

  ScalePageRoute(this.widget)
      : super(
            transitionDuration: Duration(milliseconds: 500),
            pageBuilder: (context, anim, _) => widget,
            transitionsBuilder: (context, anim, _, child) => ScaleTransition(
                  scale: Tween(begin: 0.0, end: 1.0).animate(anim),
                  child: child,
                ));
}

class FadeInPageRoute extends PageRouteBuilder {
  final Widget widget;

  FadeInPageRoute(this.widget)
      : super(
            transitionDuration: Duration(milliseconds: 1000),
            pageBuilder: (context, animation, _) => widget,
            transitionsBuilder: (context, animation, _, child) => FadeTransition(
                  opacity: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: animation, curve: Curves.ease)),
                  child: child,
                ));
}

class RotateScalePageRoute extends PageRouteBuilder {
  final Widget widget;

  RotateScalePageRoute(this.widget)
      : super(
            transitionDuration: Duration(milliseconds: 500),
            pageBuilder: (context, animation, _) => widget,
            transitionsBuilder: (context, animation, _, child) => RotationTransition(

                /// turns 值表示旋转 turns * 2π
                turns: Tween(begin: 0.0, end: 1.0).animate(
                  CurvedAnimation(parent: animation, curve: Curves.ease),
                ),
                child: ScaleTransition(
                  scale: Tween(begin: 0.1, end: 1.0).animate(
                    CurvedAnimation(parent: animation, curve: Curves.ease),
                  ),
                  child: child,
                )));
}
