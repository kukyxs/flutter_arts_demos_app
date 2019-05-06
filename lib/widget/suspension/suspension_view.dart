import 'package:flutter/material.dart';

abstract class SuspensionView {
  Object data;

  SuspensionView(this.data) : assert(data != null);

  String get tagRule;

  Widget get itemLayout;
}
