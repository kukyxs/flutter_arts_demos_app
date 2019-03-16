import 'package:flutter/material.dart';

class ThirdIcons {
  static const IconData username = ThirdIconData(0xe672);
  static const IconData password = ThirdIconData(0xe62f);
}

class ThirdIconData extends IconData {
  // fontFamily 就是我们在 `pubspec.yaml` 中注册的 family 值
  const ThirdIconData(int codePoint) : super(codePoint, fontFamily: 'ThirdPartIcons');
}
