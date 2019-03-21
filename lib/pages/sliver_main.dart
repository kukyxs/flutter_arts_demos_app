import 'package:flutter/material.dart';

class SliverDemoPage extends StatelessWidget {
  final List<Color> colors = [Colors.red, Colors.green, Colors.blue, Colors.pink];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(slivers: <Widget>[
      SliverAppBar(
        title: Text('Sliver Demo'),
        centerTitle: true,
        // 展开的高度
        expandedHeight: 300.0,
        // 强制显示阴影
        forceElevated: true,
        // 设置该属性，当有下滑手势的时候，就会显示 AppBar
        floating: true,
        // 该属性只有在 floating 为 true 的情况下使用，不然会报错
        // 当上滑到一定的比例，会自动把 AppBar 收缩（不知道是不是 bug，当 AppBar 下面的部件没有被 AppBar 覆盖的时候，不会自动收缩）
        // 当下滑到一定比例，会自动把 AppBar 展开
        snap: true,
        // 设置该属性使 Appbar 折叠后不消失
        pinned: true,
        // 通过这个属性设置 AppBar 的背景
        flexibleSpace: FlexibleSpaceBar(
//          title: Text('Expanded Title'),
          // 背景折叠动画
          collapseMode: CollapseMode.parallax,
          background: Image.asset('images/timg.jpg', fit: BoxFit.cover),
        ),
      ),

//      SliverPersistentHeader(
//        // 属性同 SliverAppBar
//        pinned: true,
//        floating: true,
//        // 因为 SliverPersistentHeaderDelegate 是一个抽象类，所以需要自定义
//        delegate: CustomSliverPersistentHeaderDelegate(
//            max: 300.0, min: 100.0, child: Image.asset('images/timg.jpg', fit: BoxFit.cover)),
//      ),

//        SliverPersistentHeader(delegate: DemoHeader(), pinned: true),

      // 如果需要设置部件之间的间隔，需要使用 SliverPadding，因为需要传入一个 sliver 的 child，
      // 所以可以通过 SliverToBoxAdapter 来进行包裹后传入，
      // 可以理解为 SliverToBoxAdapter 专门将普通的部件装饰为 sliver 部件
//      SliverPadding(
//        padding: const EdgeInsets.symmetric(vertical: 6.0),
//        sliver: SliverToBoxAdapter(
//            child: Container(
//                color: Colors.black12,
//                child: Column(children: <Widget>[
//                  Divider(height: 2.0, color: Colors.black54),
//                  Stack(
//                    alignment: Alignment.center,
//                    children: <Widget>[
//                      Image.asset('images/app_bar_hor.jpg', fit: BoxFit.cover),
//                      Text('我是一些别的东西..例如广告', textScaleFactor: 1.5, style: TextStyle(color: Colors.red))
//                    ],
//                  ),
//                  Divider(height: 2.0, color: Colors.black54),
//                ], mainAxisAlignment: MainAxisAlignment.spaceBetween),
//                alignment: Alignment.center)),
//      ),
//
      SliverFixedExtentList(
          delegate: SliverChildBuilderDelegate(
              (_, index) => Container(
                  decoration: BoxDecoration(border: Border.all(color: Colors.black12)),
                  child: Text('Item $index', style: TextStyle(color: Colors.pink, fontSize: 20.0)),
                  alignment: Alignment.center),
              childCount: 15),
          itemExtent: 80.0),

      // 可以通过 viewportFraction 设置单个 item 占屏幕的比例，默认 1.0 即为一整个屏幕的宽度
//      SliverFillViewport(
//          viewportFraction: 1.5,
//          delegate: SliverChildBuilderDelegate(
//              (_, index) =>
//                  Container(child: Text('Item $index'), alignment: Alignment.center, color: colors[index % 4]),
//              childCount: 10)),

      // 这个部件一般用于最后填充用的，会占有一个屏幕的高度，
      // 可以在 child 属性加入需要展示的部件
//      SliverFillRemaining(
//        child: Center(child: Text('FillRemaining', style: TextStyle(fontSize: 30.0))),
//      ),
    ]));
  }
}

// 自定义 SliverPersistentHeaderDelegate
class CustomSliverPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double max; // 最大高度
  final double min; // 最小高度
  final Widget child; // 需要展示的内容

  CustomSliverPersistentHeaderDelegate({@required this.max, @required this.min, @required this.child})
      // 如果 assert 内部条件不成立，会报错
      : assert(max != null),
        assert(min != null),
        assert(child != null),
        assert(min <= max),
        super();

  // 返回展示的内容，如果内容固定可以直接在这定义，如果需要可扩展，这边通过传入值来定义
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) => child;

  @override
  double get maxExtent => max; // 返回最大高度

  @override
  double get minExtent => min; // 返回最小高度

  @override
  bool shouldRebuild(CustomSliverPersistentHeaderDelegate oldDelegate) {
    // 是否需要更新，这里我们定义当高度范围和展示内容被替换的时候进行刷新界面
    return max != oldDelegate.max || min != oldDelegate.min || child != oldDelegate.child;
  }
}

class DemoHeader extends SliverPersistentHeaderDelegate {
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
        color: Colors.pink,
        alignment: Alignment.center,
        child: Text('我是一个头部部件', style: TextStyle(color: Colors.white, fontSize: 30.0)));
  } // 头部展示内容

  @override
  double get maxExtent => 300.0; // 最大高度

  @override
  double get minExtent => 100.0; // 最小高度

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => false; // 因为所有的内容都是固定的，所以不需要更新
}
