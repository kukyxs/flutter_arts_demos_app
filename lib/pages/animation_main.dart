import 'package:flutter/material.dart';

class AnimationDemoPage extends StatefulWidget {
  @override
  _AnimationDemoPageState createState() => _AnimationDemoPageState();
}

class _AnimationDemoPageState extends State<AnimationDemoPage> with TickerProviderStateMixin {
  AnimationController _animationController;
  Animation _scaleAnimation; // 用于控制图标大小
  Animation<Color> _colorAnimation; // 控制图标颜色
  Animation<Offset> _positionAnimation; // 控制图标位置

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 2000));

    // 当动画值发生变化的时候，重绘下 icon
//    _animationController.addListener(() {
//      setState(() {});
//    });

    _animationController.addStatusListener((status) {
      if (_animationController.status == AnimationStatus.completed)
        _animationController.reverse();
      else if (_animationController.status == AnimationStatus.dismissed) _animationController.forward();
    });

    // 通过 `Tween` 的 `animate` 生成一个 Animation
    // 再通过  Animation.value 进行值的修改
    // 通过 `chain` 结合 `CurveTween` 修改动画的运动方式
    _scaleAnimation =
        Tween(begin: 28.0, end: 50.0).chain(CurveTween(curve: Curves.decelerate)).animate(_animationController);

    _colorAnimation = ColorTween(begin: Colors.red[200], end: Colors.red[900])
        .chain(CurveTween(curve: Curves.easeIn))
        .animate(_animationController);

    _positionAnimation = Tween(begin: Offset(100, 100), end: Offset(300, 300))
        .chain(CurveTween(curve: Curves.bounceInOut))
        .animate(_animationController);

    _animationController.forward(); // 启动动画
  }

  @override
  void dispose() {
    // 一定要释放资源
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animation Demo'),
      ),
//      body: Center(
//        child: IconButton(
//            icon: Icon(Icons.android, color: Colors.green[500], size: _animationController.value),
//            onPressed: () {
//              // 根据状态执行不同动画运动方式
//              if (_animationController.status == AnimationStatus.completed)
//                _animationController.reverse();
//              else if (_animationController.status == AnimationStatus.dismissed)
//                _animationController.forward();
//            }),
//      ),

//      body: Center(
//        child: Icon(Icons.favorite, color: Colors.red, size: _scaleAnimation.value),
//      ),

//      body: Stack(
//        children: <Widget>[
//          Positioned(
//            child: Icon(Icons.favorite, color: _colorAnimation.value, size: _scaleAnimation.value),
//            left: _positionAnimation.value.dx,
//            top: _positionAnimation.value.dy,
//          )
//        ],
//      ),

//      body: RunningHeart(
//        animations: [_colorAnimation, _scaleAnimation, _positionAnimation],
//        animationController: _animationController,
//      ),

      body: Container(
        alignment: Alignment.center,
        child: InkWell(
          child: Hero(
            tag: 'hero_tag',
            child: Image.asset('images/ali.jpg', width: 100.0, height: 100.0),
          ),
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => HeroPage())),
        ),
      ),
    );
  }
}

class RunningHeart extends AnimatedWidget {
  final List<Animation> animations; // 传入动画列表
  final AnimationController animationController; // 控制动画

  RunningHeart({this.animations, this.animationController})
      : assert(animations.length == 3),
        assert(animations[0] is Animation<Color>),
        assert(animations[1] is Animation<double>),
        assert(animations[2] is Animation<Offset>),
        super(listenable: animationController);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          child: Icon(Icons.favorite, color: animations[0].value, size: animations[1].value),
          left: animations[2].value.dx,
          top: animations[2].value.dy,
        )
      ],
    );
  }
}

class HeroPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: InkWell(
          child: Hero(tag: 'hero_tag', child: Image.asset('images/ali.jpg', width: 200.0, height: 200.0)),
          onTap: () => Navigator.pop(context),
        ),
      ),
    );
  }
}
