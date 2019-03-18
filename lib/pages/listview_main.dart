import 'package:flutter/material.dart';

class ListViewDemoPage extends StatelessWidget {
  final List<String> letters = [
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
    'L',
    'M',
    'N',
    'O',
    'P',
    'Q',
    'R',
    'S',
    'T',
    'U',
    'V',
    'W',
    'X',
    'Y',
    'Z'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ListView Demo'),
      ),

      // 最普通的生成方式，例如每个 item 都不一样，需要通过一个个添加的方式，推荐使用
//      body: ListView(
//          // 通过修改滑动方向设置水平或者垂直方向滚动
//          scrollDirection: Axis.vertical,
//          // 通过 iterable.map().toList 和 List.generate 方法效果是一样的
//          children: letters
//              .map((s) => Padding(
//                  padding: const EdgeInsets.symmetric(vertical: 8.0),
//                  child: Center(
//                    child: Text(s),
//                  )))
//              .toList()),

//      body: ListView.custom(
//          // 指定 item 的高度，可以加快渲染的速度
//          itemExtent: 40.0,
//          // item 代理
//          childrenDelegate: SliverChildBuilderDelegate(
//            // IndexedWidgetBuilder，根据 index 设置 item 中需要变化的数据
//            (_, index) => Center(child: Text(letters[index], style: TextStyle(color: Colors.red))),
//            // 指定 item 的数量
//            childCount: letters.length,
//          )),

      // 推荐指数：5星
//      body: ListView.builder(
//          itemBuilder: (_, index) => Center(child: Text(letters[index], style: TextStyle(color: Colors.green))),
//          itemExtent: 40.0,
//          itemCount: letters.length),

      // 需要分割线的时候才使用，不能指定 item 的高度
      body: ListView.separated(
          itemBuilder: (_, index) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Center(child: Text(letters[index], style: TextStyle(color: Colors.blue))),
              ),
          separatorBuilder: (_, index) => Divider(height: 1.0, color: index % 2 == 0 ? Colors.black : Colors.red),
          itemCount: letters.length),
    );
  }
}
