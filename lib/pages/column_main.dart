import 'package:flutter/material.dart';

class ColumnDemoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        alignment: Alignment.center,
        // 宽，高度同上层容器相同
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(20.0),
//        color: Theme.of(context).primaryColor, // 该属性不可和 decoration 一起使用
        // Container 的样式
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: Colors.red,
//            shape: BoxShape.circle, // 该属性不可同 borderRadius 一起使用
            backgroundBlendMode: BlendMode.colorDodge, // 背景图片和颜色混合模式
            image: DecorationImage(image: AssetImage('images/ali.jpg'), fit: BoxFit.cover)),

//        child: Column(
//          children: <Widget>[
//            Text('Container Text', style: TextStyle(color: Colors.white, fontSize: 30.0)),
//            Padding(
//                padding: const EdgeInsets.symmetric(vertical: 12.0),
//                child: Text('Container Text', style: TextStyle(color: Colors.white, fontSize: 30.0)))
//          ],
//        ),
        child: Wrap(
          spacing: 50.0,
          runAlignment: WrapAlignment.center,
          runSpacing: 50.0,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: <Widget>[
            Text('ABC' * 10, style: TextStyle(color: Colors.white, fontSize: 16.0)),
            Text('ABC' * 4, style: TextStyle(color: Colors.white, fontSize: 16.0)),
            Text('ABC' * 5, style: TextStyle(color: Colors.white, fontSize: 16.0)),
            Text('ABC' * 5, style: TextStyle(color: Colors.white, fontSize: 16.0)),
            Text('ABC' * 20, style: TextStyle(color: Colors.white, fontSize: 16.0))
          ],
        ),
//        child: Column(
//          mainAxisAlignment: MainAxisAlignment.spaceAround,
//          children: <Widget>[
//            Text('Container Text 1', style: TextStyle(color: Colors.white, fontSize: 30.0)),
//            Text('Container Text 2', style: TextStyle(color: Colors.white, fontSize: 30.0)),
//            Text('Container Text 3', style: TextStyle(color: Colors.white, fontSize: 30.0)),
//            Text('Container Text 4', style: TextStyle(color: Colors.white, fontSize: 30.0)),
//            Text('Container Text 5', style: TextStyle(color: Colors.white, fontSize: 30.0)),
//          ],
//        ),
      )),
    );
  }
}
