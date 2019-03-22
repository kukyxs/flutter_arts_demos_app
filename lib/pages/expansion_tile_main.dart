import 'package:flutter/material.dart';

class ExpansionTilesDemoPage extends StatelessWidget {
  final _keys = ['ParentA', 'ParentB', 'ParentC', 'ParentD', 'ParentE', 'ParentF'];
  final Map<String, List<String>> _data = {
    'ParentA': ['Child A0', 'Child A1', 'Child A2', 'Child A3', 'Child A4', 'Child A5'],
    'ParentB': ['Child B0', 'Child B1', 'Child B2', 'Child B3', 'Child B4', 'Child B5'],
    'ParentC': ['Child C0', 'Child C1', 'Child C2', 'Child C3', 'Child C4', 'Child C5'],
    'ParentD': ['Child D0', 'Child D1', 'Child D2', 'Child D3', 'Child D4', 'Child D5'],
    'ParentE': ['Child E0', 'Child E1', 'Child E2', 'Child E3', 'Child E4', 'Child E5'],
    'ParentF': ['Child F0', 'Child F1', 'Child F2', 'Child F3', 'Child F4', 'Child F5']
  };

  final _forthLevelData = [
    [
      ['A0', 'A1', 'A2', 'A3'],
      ['B0', 'B1', 'B2', 'B3']
    ],
    [
      ['Aa0', 'Aa1', 'Aa2', 'Aa3'],
      ['Bb0', 'Bb1', 'Bb2', 'Bb3']
    ]
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ExpansionTile Demo'),
      ),
//      body: ExpansionTile(
//        // 最前面的 widget
//        leading: Icon(Icons.phone_android),
//        // 替换默认箭头
////        trailing: Icon(Icons.phone_iphone),
//        title: Text('Parent'),
//        // 默认是否展开
//        initiallyExpanded: true,
//        // 展开时候的背景色
//        backgroundColor: Colors.yellow[100],
//        // 展开或者收缩的回调，true 表示展开
//        onExpansionChanged: (expanded) => print('ExpansionTile is ${expanded ? 'expanded' : 'collapsed'}'),
//        children: List.generate(
//            10,
//                (position) =>
//                Container(
//                  padding: const EdgeInsets.only(left: 80.0),
//                  child: Text('Children ${position + 1}'),
//                  height: 50.0,
//                  alignment: Alignment.centerLeft,
//                )),
//      ),

//      body: ListView(
//          children: _keys
//              .map((key) => ExpansionTile(
//                    title: Text(key),
//                    children: _data[key]
//                        .map((value) => InkWell(
//                            child: Container(
//                              child: Text(value),
//                              padding: const EdgeInsets.only(left: 80.0),
//                              height: 50.0,
//                              alignment: Alignment.centerLeft,
//                            ),
//                            onTap: () {}))
//                        .toList(),
//                  ))
//              .toList()),

      body: SingleChildScrollView(
        child: ExpansionTile(
            title: Text('1stParent'),
            children: _forthLevelData
                .map((threeLevelData) => ExpansionTile(
                    title: Text('2ndParent'),
                    children: threeLevelData
                        .map((towLevelData) => ExpansionTile(
                              title: Text('3rdParent'),
                              children: towLevelData
                                  .map((lastLevelData) => Container(child: Text(lastLevelData), height: 50.0))
                                  .toList(),
                            ))
                        .toList()))
                .toList()),
      ),
    );
  }
}
