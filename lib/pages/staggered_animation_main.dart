import 'package:flutter/material.dart';

class StaggeredAnimationsDemoPage extends StatefulWidget {
  @override
  _StaggeredAnimationsDemoPageState createState() => _StaggeredAnimationsDemoPageState();
}

class _StaggeredAnimationsDemoPageState extends State<StaggeredAnimationsDemoPage> with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 5000));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _playAnim() async {
    try {
      await _controller.forward().orCancel;
      await _controller.reverse().orCancel;
    } on TickerCanceled {
      print('cancel');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('StaggeredAnimation Demo'),
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: _playAnim,
        child: Center(
          // 定义一个外层圈，能够使动画显眼点
          child: Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.1), border: Border.all(color: Colors.black.withOpacity(0.5))),
            child: StaggeredAnim(controller: _controller),
          ),
        ),
      ),
    );
  }
}

class StaggeredAnim extends StatelessWidget {
  final AnimationController controller;
  final Animation<double> opacity;
  final Animation<double> width;
  final Animation<double> height;
  final Animation<EdgeInsets> padding;
  final Animation<BorderRadius> border;
  final Animation<Color> color;
  final Animation<double> rotate;

  StaggeredAnim({Key key, this.controller})
      :
        // widget 透明度
        opacity = Tween(begin: 0.0, end: 1.0)
            .animate(CurvedAnimation(parent: controller, curve: Interval(0.0, 0.1, curve: Curves.ease))),
        // widget 宽
        width = Tween(begin: 50.0, end: 150.0)
            .animate(CurvedAnimation(parent: controller, curve: Interval(0.1, 0.250, curve: Curves.ease))),
        // widget 高
        height = Tween(begin: 50.0, end: 150.0)
            .animate(CurvedAnimation(parent: controller, curve: Interval(0.25, 0.375, curve: Curves.ease))),
        // widget 底部距离
        padding = EdgeInsetsTween(begin: const EdgeInsets.only(top: 150.0), end: const EdgeInsets.only(top: .0))
            .animate(CurvedAnimation(parent: controller, curve: Interval(0.25, 0.375, curve: Curves.ease))),
        // widget 旋转
        rotate = Tween(begin: 0.0, end: 0.25)
            .animate(CurvedAnimation(parent: controller, curve: Interval(0.375, 0.5, curve: Curves.ease))),
        // widget 外形
        border = BorderRadiusTween(begin: BorderRadius.circular(5.0), end: BorderRadius.circular(75.0))
            .animate(CurvedAnimation(parent: controller, curve: Interval(0.5, 0.75, curve: Curves.ease))),
        // widget 颜色
        color = ColorTween(begin: Colors.blue, end: Colors.orange)
            .animate(CurvedAnimation(parent: controller, curve: Interval(0.75, 1.0, curve: Curves.ease))),
        super(key: key);

  Widget _buildAnimWidget(BuildContext context, Widget child) {
    return Container(
      padding: padding.value,
      alignment: Alignment.center,
      // 旋转变化
      child: RotationTransition(
        turns: rotate, // turns 表示当前动画的值 * 360° 角度
        child: Opacity(
          opacity: opacity.value, // 透明度变化
          child: Container(
            width: width.value, // 宽度变化
            height: height.value, // 高度变化
            decoration: BoxDecoration(
                color: color.value, // 颜色变化
                border: Border.all(color: Colors.indigo[300], width: 3.0),
                borderRadius: border.value), // 外形变化
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(animation: controller, builder: _buildAnimWidget);
  }
}
