import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(DemoApp());

  if (Platform.isAndroid) {
    var style = SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(style);
  }
}

class DemoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.lightBlue),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  List<String> _abs = ['A', 'B', 'S'];
  TabController _tabController;

  // 用于同 TabBar 进行联动
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _abs.length, vsync: this);
    _pageController = PageController(initialPage: 0);

    _tabController.addListener(() {
      // 判断 TabBar 是否切换位置了，如果切换了，则修改 PageView 的显示
      if (_tabController.indexIsChanging) {
        // PageView 的切换通过 controller 进行滚动
        // duration 表示切换滚动的时长，curve 表示滚动动画的样式，
        // flutter 已经在 Curves 中定义许多样式，可以自行切换查看效果
        _pageController.animateToPage(_tabController.index,
            duration: Duration(milliseconds: 300), curve: Curves.decelerate);
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
//        automaticallyImplyLeading: false,
//        leading: Icon(Icons.menu, color: Colors.red, size: 30.0),
//        flexibleSpace: Image.asset('images/app_bar_hor.jpg', fit: BoxFit.cover),
        title: Text('AppBar Demo', style: TextStyle(color: Colors.red)),
        actions: <Widget>[
          PopupMenuButton(
              offset: Offset(50.0, 100.0),
              onSelected: (val) => print('Selected item is $val'),
              icon: Icon(Icons.more_vert, color: Colors.red),
              itemBuilder: (context) =>
                  List.generate(_abs.length, (index) => PopupMenuItem(value: _abs[index], child: Text(_abs[index]))))
        ],
        bottom: TabBar(
            labelColor: Colors.red,
            unselectedLabelColor: Colors.white,
            controller: _tabController,
            isScrollable: false,
            indicatorColor: Colors.yellow,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorWeight: 5.0,
            tabs: List.generate(_abs.length, (index) => Tab(text: _abs[index], icon: Icon(Icons.android)))),
      ),
      // 通过 body 来展示内容，body 可以传入任何 Widget，里面就是你需要展示的界面内容
      // 所以前面留下 Scaffold 中 body 部分的坑就解决了
      body: PageView(
        controller: _pageController,
        children:
            _abs.map((str) => TabChangePage(content: str)).toList(), // 通过 Map 转换后再通过 toList 转换成列表，效果同 List.generate
        onPageChanged: (position) {
          // PageView 切换的监听，这边切换 PageView 的页面后，TabBar 也需要随之改变
          // 通过 tabController 来改变 TabBar 的显示位置
          _tabController.index = position;
        },
      ),
      drawer: Drawer(
        child: SafeArea(
            child: Container(
          child: Text('Drawer', style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 30.0)),
        )),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(icon: Icon(Icons.android, size: 30.0, color: Theme.of(context).primaryColor), onPressed: () {}),
            IconButton(icon: Icon(Icons.people, size: 30.0, color: Theme.of(context).primaryColor), onPressed: () {})
          ],
        ),
      ),
      floatingActionButton:
          FloatingActionButton(onPressed: () => print('Add'), child: Icon(Icons.add, color: Colors.white)),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );

    //    return Scaffold(body: TabChangePage(content: 'Content'));
  }
}

class TabChangePage extends StatelessWidget {
  // 需要传入的参数
  final String content;

  // TabChangePage(this.content); 不推荐这样写构造方法

  // 推荐用这样的构造方法，key 可以作为唯一值查找
  TabChangePage({Key key, this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
            alignment: Alignment.center,
            child: Text(content, style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 30.0))));
  }
}
