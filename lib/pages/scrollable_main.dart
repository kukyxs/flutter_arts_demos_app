import 'package:flutter/material.dart';
import 'package:flutter_arts_demos_app/pages/gridview_main.dart';
import 'package:flutter_arts_demos_app/pages/listview_main.dart';
import 'package:flutter_arts_demos_app/pages/single_child_scroll_main.dart';

import '../main.dart';

class ScrollableDemoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scrollable Demo'),
      ),
      body: Column(children: <Widget>[
        MenuActionItem(
            title: 'SingleChildScrollView',
            clickAction: () => Navigator.push(context, MaterialPageRoute(builder: (_) => SingleChildScrollDemoPage()))),
        MenuActionItem(
            title: 'ListView',
            clickAction: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ListViewDemoPage()))),
        MenuActionItem(
            title: 'GridView',
            clickAction: () => Navigator.push(context, MaterialPageRoute(builder: (_) => GridViewDemoPage()))),
//        MenuActionItem(title: 'CustomScrollView', clickAction: null),
      ]),
    );
  }
}
