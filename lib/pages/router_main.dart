import 'package:flutter/material.dart';

/// router 测试界面需要单独运行
class DemoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Learning Demo',
      // 在这里注册路由，关联 name 和界面
      // '/' 表示根页面，也就是 home 所对应的页面
      routes: {'/': (_) => APage(), /*'/page_b': (_) => BPage(),*/ '/page_c': (_) => CPage()},
      debugShowCheckedModeBanner: false,
    );
  }
}

class APage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page A'),
      ),
      body: Center(
          child: RaisedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => BPage(message: 'Message From Page A')))
                    .then((value) => print('BACK MESSAGE => $value'));
//                Navigator.pushNamed(context, '/page_b');
//                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => BPage()));
//                Navigator.pushReplacementNamed(context, '/page_b');
//                Navigator.popAndPushNamed(context, '/page_b');
              },
              child: Text('To Page B'))),
    );
  }
}

class BPage extends StatelessWidget {
  final String message;

  BPage({Key key, @required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('passed value: $message');
    return Scaffold(
      appBar: AppBar(
        title: Text('Page B'),
      ),
      body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
        RaisedButton(
            onPressed: () {
//              Navigator.pushAndRemoveUntil(
//                  context, MaterialPageRoute(builder: (_) => CPage()), (Route router) => false);
//              Navigator.pushNamedAndRemoveUntil(context, '/page_c', (Route router) => false);
//              Navigator.pushAndRemoveUntil(
//                  context, MaterialPageRoute(builder: (_) => CPage()), ModalRoute.withName('/'));
//              Navigator.pushNamedAndRemoveUntil(context, '/page_c', ModalRoute.withName('/'));
//              Navigator.popAndPushNamed(context, '/page_c');
//              Navigator.push(context, MaterialPageRoute(builder: (_) => CPage()))
//                  .then((value) => print('Message Form C: $value'));
              Navigator.push(
                  context,
                  PageRouteBuilder(
                      // 返回目标页面
                      pageBuilder: (context, anim, _) => CPage(),
                      // 切换动画的切换时长
                      transitionDuration: Duration(milliseconds: 500),
                      // 切换动画的切换效果，系统自带的常用 Transition
                      // ScaleTransition: 缩放  SlideTransition: 滑动
                      // RotationTransition: 旋转  FadeTransition: 透明度
                      transitionsBuilder: (context, anim, _, child) => ScaleTransition(
                            // Tween 是 flutter 的补间动画
                            scale: Tween(begin: 0.0, end: 1.0).animate(anim),
                            // 这个值必须记得要传，否则会不显示界面
                            child: FadeTransition(
                              opacity: Tween(begin: 0.0, end: 1.0).animate(anim),
                              child: child,
                            ),
                          )));
            },
            child: Text('To Page C')),
        RaisedButton(
            onPressed: () {
              Navigator.pop(context, 'Message back to PageA From BPage');
            },
            child: Text('Back Page A'))
      ])),
    );
  }
}

class CPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(
            title: Text('Page C'),
          ),
          body: Center(
              child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            RaisedButton(
                onPressed: () {
                  Navigator.popUntil(context, ModalRoute.withName('/'));
                },
                child: Text('Back Last Page'))
          ])),
        ),
        onWillPop: () async {
          Navigator.pop(context, 'Hello~');
          return false;
        });
  }
}
