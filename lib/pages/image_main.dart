import 'package:flutter/material.dart';

class ImageDemoPage extends StatelessWidget {
  final String _assetAli = 'images/ali.jpg';
  final String _picUrl =
      'https://timg05.bdimg.com/timg?wapbaike&quality=60&size=b1440_952&cut_x=143&cut_y=0&cut_w=1633&'
      'cut_h=1080&sec=1349839550&di=cbbc175a45ccec5482ce2cff09a3ae34&'
      'src=http://imgsrc.baidu.com/baike/pic/item/4afbfbedab64034f104872baa7c379310b551d80.jpg';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Container(
          padding: const EdgeInsets.only(top: 10.0),
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // 这种展示图片方式和下一种会有相同的效果
              Image(image: AssetImage(_assetAli), width: 80.0, height: 80.0),
              // 接下来加载图片都会使用这些比较方便的方法
              Image.asset(_assetAli, width: 80.0, height: 80.0),
              // 加载一张网络图片
              Image.network(_picUrl,
                  height: 80.0,
                  // 横向重复
                  repeat: ImageRepeat.repeatX,
                  // MediaQuery.of(context).size 获取到的为上层容器的宽高
                  width: MediaQuery.of(context).size.width),
              // 通过设置混合模式，可以看到图片展示的样式已经修改
              Image.asset(_assetAli,
                  width: 80.0, height: 80.0, color: Colors.green, colorBlendMode: BlendMode.colorDodge),
              // 会优先加载指定的 asset 图片，然后等网络图片读取成功后加载网络图片，会通过渐隐渐现方式展现
              // cover 方式按照较小的边布满，较大的给切割
              // contain 会按照最大的边布满，较小的会被留白
              // fill 会把较大的一边压缩
              // fitHeight, fitWidth 分别按照长宽来布满
              FadeInImage.assetNetwork(
                  placeholder: _assetAli, image: _picUrl, width: 120.0, height: 120.0, fit: BoxFit.cover),
              Icon(Icons.android, size: 40.0, color: Theme.of(context).primaryColorDark)
            ],
          )),
        ));
  }
}
