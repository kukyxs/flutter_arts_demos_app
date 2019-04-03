import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_arts_demos_app/application.dart';
import 'package:flutter_arts_demos_app/bloc/bloc_provider.dart';
import 'package:flutter_arts_demos_app/bloc_network/user_bloc.dart';
import 'package:flutter_arts_demos_app/bloc_network/user_page_main.dart';
import 'package:flutter_arts_demos_app/custom_routes.dart';
import 'package:flutter_arts_demos_app/http_utils.dart';
import 'package:flutter_arts_demos_app/pages/animation_main.dart';
import 'package:flutter_arts_demos_app/pages/app_bar_main.dart';
import 'package:flutter_arts_demos_app/pages/button_main.dart';
import 'package:flutter_arts_demos_app/pages/checkbox_switch_main.dart';
import 'package:flutter_arts_demos_app/pages/column_main.dart';
import 'package:flutter_arts_demos_app/pages/data_persistence_main.dart';
import 'package:flutter_arts_demos_app/pages/expansion_tile_main.dart';
import 'package:flutter_arts_demos_app/pages/gesture_main.dart';
import 'package:flutter_arts_demos_app/pages/http_main.dart';
import 'package:flutter_arts_demos_app/pages/image_main.dart';
import 'package:flutter_arts_demos_app/pages/login_home_page.dart';
import 'package:flutter_arts_demos_app/pages/prompt_main.dart';
import 'package:flutter_arts_demos_app/pages/scrollable_main.dart';
import 'package:flutter_arts_demos_app/pages/sliver_main.dart';
import 'package:flutter_arts_demos_app/pages/stack_main.dart';
import 'package:flutter_arts_demos_app/pages/staggered_animation_main.dart';
import 'package:flutter_arts_demos_app/pages/text_field_main.dart';
import 'package:flutter_arts_demos_app/pages/text_main.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  Application.http = HttpUtils('https://randomuser.me');
  // 强制竖屏
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]).then((_) {
    runApp(DemoApp());

    // 透明状态栏
    if (Platform.isAndroid) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    }
  });
}

class DemoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Learning Demo',
      home: MainHomePage(),
      routes: {},
      supportedLocales: const [const Locale('zh')],
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainHomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(title: Text('Flutter Learning Demo')),
        body: ListView(children: <Widget>[
          MenuActionItem(
            title: 'AppBar Demo',
            clickAction: () => Navigator.push(context, ScalePageRoute(AppBarDemoPage())),
          ),
          MenuActionItem(
            title: 'Text Demo',
            clickAction: () => Navigator.push(context, FadeInPageRoute(TextDemoPage())),
          ),
          MenuActionItem(
            title: 'Image Demo',
            clickAction: () => Navigator.push(context, RotateScalePageRoute(ImageDemoPage())),
          ),
          MenuActionItem(
            title: 'Button Demo',
            // CupertinoPageRoute 为 iOS 风格切换，支持侧滑关闭当前页面
            clickAction: () => Navigator.push(context, CupertinoPageRoute(builder: (_) => ButtonDemoPage())),
          ),
          MenuActionItem(
            title: 'Column Demo',
            clickAction: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ColumnDemoPage())),
          ),
          MenuActionItem(
            title: 'Stack Demo',
            clickAction: () => Navigator.push(context, ScalePageRoute(StackDemoPage())),
          ),
          MenuActionItem(
            title: 'Check Switch Demo',
            clickAction: () => Navigator.push(context, ScalePageRoute(CheckSwitchDemoPage())),
          ),
          MenuActionItem(
            title: 'TextField Demo',
            clickAction: () => Navigator.push(context, FadeInPageRoute(TextFieldDemoPage())),
          ),
          MenuActionItem(
            title: 'Login Demo',
            clickAction: () => Navigator.push(context, RotateScalePageRoute(LoginDemoPage())),
          ),
          MenuActionItem(
              title: 'Scrollable Demo',
              clickAction: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ScrollableDemoPage()))),
          MenuActionItem(
              title: 'ExpansionTile Demo',
              clickAction: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ExpansionTilesDemoPage()))),
          MenuActionItem(
              title: 'Sliver Demo',
              clickAction: () => Navigator.push(context, MaterialPageRoute(builder: (_) => SliverDemoPage()))),
          MenuActionItem(
              title: 'Prompt Demo',
              clickAction: () => Navigator.push(context, MaterialPageRoute(builder: (_) => PromptDemoPage()))),
          MenuActionItem(
              title: 'Gesture Demo',
              clickAction: () => Navigator.push(context, MaterialPageRoute(builder: (_) => GestureDemoPage()))),
          MenuActionItem(
              title: 'Animation Demo',
              clickAction: () => Navigator.push(context, MaterialPageRoute(builder: (_) => AnimationDemoPage()))),
          MenuActionItem(
              title: 'StaggeredAnimations Demo',
              clickAction: () =>
                  Navigator.push(context, MaterialPageRoute(builder: (_) => StaggeredAnimationsDemoPage()))),
          MenuActionItem(
              title: 'DataPersistence Demo',
              clickAction: () => Navigator.push(context, MaterialPageRoute(builder: (_) => DataPersistenceDemoPage()))),
          MenuActionItem(
              title: 'Http Demo',
              clickAction: () => Navigator.push(context, MaterialPageRoute(builder: (_) => HttpDemoPage()))),
          MenuActionItem(
              title: 'BlocHttp Demo',
              clickAction: () => Navigator.push(
                  context, MaterialPageRoute(builder: (_) => BlocProvider(child: UserPageDemo(), bloc: UserBloc())))),

          /// Router 界面因为涉及到带 `Name` 方法的执行，需要单独运行 `router_main.dart` 文件
//          MenuActionItem(
//            title: 'Route Demo',
//            clickAction: () => Navigator.push(context, MaterialPageRoute(builder: (_) => APage())),
//          ),
        ]) /*,
      floatingActionButton: FloatingActionButton(
        mini: true,
        onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider<FuliBloc>(child: FuliPage(), bloc: FuliBloc()),
            )),
        child: Icon(Icons.beach_access, color: Colors.red),
      ),*/
        );
  }
}

/// 点击跳转组件
class MenuActionItem extends StatelessWidget {
  final String title;
  final VoidCallback clickAction;

  MenuActionItem({Key key, @required this.title, @required this.clickAction})
      : assert(title != null),
        assert(clickAction != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
              Text(title, style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 18.0)),
              Icon(Icons.arrow_forward_ios, size: 24.0, color: Theme.of(context).primaryColor)
            ])),
        onTap: clickAction);
  }
}
