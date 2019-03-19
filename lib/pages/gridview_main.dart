import 'package:flutter/material.dart';

class GridViewDemoPage extends StatelessWidget {
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

  // 用于区分网格单元
  final List<Color> colors = [Colors.red, Colors.green, Colors.blue, Colors.pink];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GridView Demo'),
      ),

//      body: GridView(
//        // gridDelegate 目前为两种
//        // `SliverGridDelegateWithFixedCrossAxisCount` 固定单排数量的 Delegate，相对使用比较多
//        // `SliverGridDelegateWithMaxCrossAxisExtent` 设置单个 item 最大宽度/长度，单排会按照最少的数量进行排布
//        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//            crossAxisCount: 5, // 单行的个数
//            mainAxisSpacing: 10.0, // 同 scrollDirection 挂钩，item 之间在主轴方向的间隔
//            crossAxisSpacing: 10.0, // item 之间在副轴方法的间隔
//            childAspectRatio: 1.0 // item 的宽高比
//            ),
//        // 需要根据 index 设置不同背景色，所以使用 List.generate，如果不设置背景色，也可用 iterable.map().toList
//        children: List.generate(
//            letters.length,
//            (index) => Container(
//                  alignment: Alignment.center,
//                  child: Text(letters[index]),
//                  color: colors[index % 4],
//                )),
//      ),

//      body: GridView(
//        // 通过设置 `maxCrossAxisExtent` 来指定最大的宽度，在这个值范围内，会选取相对较大的值
//        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
//            maxCrossAxisExtent: 60.0, crossAxisSpacing: 10.0, mainAxisSpacing: 10.0, childAspectRatio: 1.0),
//        children: List.generate(
//            letters.length,
//            (index) => Container(
//                  alignment: Alignment.center,
//                  child: Text(letters[index]),
//                  color: colors[index % 4],
//                )),
//      ),

      // 通过 `IndexedWidgetBuilder` 来构建 item，别的参数同上
      body: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5, crossAxisSpacing: 10.0, mainAxisSpacing: 10.0, childAspectRatio: 1.0),
          itemCount: letters.length,
          itemBuilder: (_, index) =>
              Container(color: colors[index % 4], child: Text(letters[index]), alignment: Alignment.center)),

//      body: GridView.custom(
//          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//              crossAxisCount: 5, mainAxisSpacing: 10.0, crossAxisSpacing: 10.0, childAspectRatio: 1.0),
//          // item 通过 delegate 来生成，内部实现还是 `IndexedWidgetBuilder`
//          childrenDelegate: SliverChildBuilderDelegate(
//              (_, index) => Container(
//                    alignment: Alignment.center,
//                    color: colors[index % 4],
//                    child: Text(letters[index]),
//                  ),
//              childCount: letters.length)),

//      body: GridView.custom(
//          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5),
//          // 内部通过返回控件列表实现
//          childrenDelegate: SliverChildListDelegate(
//            List.generate(
//                letters.length,
//                (index) => Container(
//                      child: Text(letters[index]),
//                      alignment: Alignment.center,
//                      color: colors[index % 4],
//                    )),
//          )),

      // 这种情况就是简化了 `GridView` 使用 `SliverGridDelegateWithFixedCrossAxisCount` 代理的方法
//      body: GridView.count(
//          crossAxisCount: 5,
//          childAspectRatio: 2.0,
//          children: List.generate(
//              letters.length,
//              (index) => Container(
//                    alignment: Alignment.center,
//                    color: colors[index % 4],
//                    child: Text(letters[index]),
//                  ))),

      // 这种情况就是简化了 `GridView` 使用 `SliverGridDelegateWithMaxCrossAxisExtent` 代理的方法
//      body: GridView.extent(
//          crossAxisSpacing: 10.0,
//          mainAxisSpacing: 10.0,
//          childAspectRatio: 1.0,
//          maxCrossAxisExtent: 80.0,
//          children: List.generate(
//              letters.length,
//              (index) => Container(
//                    alignment: Alignment.center,
//                    color: colors[index % 4],
//                    child: Text(letters[index]),
//                  ))),
    );
  }
}
