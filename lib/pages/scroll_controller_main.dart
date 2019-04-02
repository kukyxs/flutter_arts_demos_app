import 'package:flutter/material.dart';

class ScrollControllerDemoPage extends StatefulWidget {
  @override
  _ScrollControllerDemoPageState createState() => _ScrollControllerDemoPageState();
}

class _ScrollControllerDemoPageState extends State<ScrollControllerDemoPage> {
  var _scrollController = ScrollController();
  var _showBackTop = false;

  @override
  void initState() {
    super.initState();

    // 对 scrollController 进行监听
    _scrollController.addListener(() {
      // _scrollController.position.pixels 获取当前滚动部件滚动的距离
      // 当滚动距离大于 800 之后，显示回到顶部按钮
      setState(() => _showBackTop = _scrollController.position.pixels >= 800);
    });
  }

  @override
  void dispose() {
    // 记得销毁对象
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ScrollController Demo'),
      ),
      body: ListView(
        controller: _scrollController,
        children: List.generate(
            20, (index) => Container(height: 100.0, alignment: Alignment.center, child: Text('Item ${index + 1}'))),
      ),
      floatingActionButton: _showBackTop // 当需要显示的时候展示按钮，不需要的时候隐藏，设置 null
          ? FloatingActionButton(
              onPressed: () {
                // scrollController 通过 animateTo 方法滚动到某个具体高度
                // duration 表示动画的时长，curve 表示动画的运行方式，flutter 在 Curves 提供了许多方式
                _scrollController.animateTo(0.0, duration: Duration(milliseconds: 500), curve: Curves.decelerate);
              },
              child: Icon(Icons.vertical_align_top),
            )
          : null,
    );
  }
}
