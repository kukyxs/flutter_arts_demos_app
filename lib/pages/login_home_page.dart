import 'package:flutter/material.dart';
import 'package:flutter_arts_demos_app/third_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginDemoPage extends StatefulWidget {
  @override
  _LoginDemoPageState createState() => _LoginDemoPageState();
}

class _LoginDemoPageState extends State<LoginDemoPage> with SingleTickerProviderStateMixin {
  TabController _tabController;
  List<String> _pageIndicators = ['登录', '注册'];
  List<Widget> _pages = [];
  int _position = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _pageIndicators.length, vsync: this);
    _pages..add(LoginPage())..add(RegisterPage());

    _tabController.addListener(() {
      // 当 tab 切换的时候，联动 IndexStack 的 child 页面也进行修改，通过 setState 来修改值
      if (_tabController.indexIsChanging) setState(() => _position = _tabController.index);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: ThemeData(primarySwatch: Colors.pink, iconTheme: IconThemeData(color: Colors.pink)),
        child: Scaffold(
          body: Container(
            padding: const EdgeInsets.all(20.0),
            alignment: Alignment.center,
            decoration:
                BoxDecoration(image: DecorationImage(image: AssetImage('images/login_bg.png'), fit: BoxFit.cover)),
            child: SingleChildScrollView(
              child: SafeArea(
                  child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
                // 顶部页面切换指示器
                TabBar(
                    indicatorSize: TabBarIndicatorSize.label,
                    controller: _tabController,
                    indicatorWeight: 4.0,
                    indicatorColor: Colors.white,
                    tabs: _pageIndicators
                        .map((v) => Text(v, style: TextStyle(color: Colors.white, fontSize: 24.0)))
                        .toList()),
                Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: SizedBox(
                        // 切换界面列表
                        child: IndexedStack(children: _pages, index: _position),
                        height: MediaQuery.of(context).size.height / 2))
              ])),
            ),
          ),
        ));
  }
}

/// 登录界面
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  _login() {
    // 取消焦点
    FocusScope.of(context).requestFocus(FocusNode());

    // 判断表单是否有效
    if (_formKey.currentState.validate()) {
      // 获取输入框内容
      var username = _usernameController.value.text;
      var password = _passwordController.value.text;

      // 判断登录条件
      if (username == 'kuky' && password == '123456') {
        Fluttertoast.showToast(msg: '登录成功');
        Navigator.pop(context);
      } else
        Fluttertoast.showToast(msg: '登录失败');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        // 将 key 设置给表单，用于判断表单是否有效
        key: _formKey,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              // 表单输入框，参数同 TextField 基本类似
              child: TextFormField(
                controller: _usernameController,
                style: TextStyle(color: Colors.white, fontSize: 16.0),
                decoration: InputDecoration(
                    icon: Icon(ThirdIcons.username, size: 24.0, color: Colors.white),
                    labelText: '请输入用户名',
                    labelStyle: TextStyle(color: Colors.white),
                    helperStyle: TextStyle(color: Colors.white)),
                // 有效条件(为空不通过，返回提示语，通过返回 null)
                validator: (value) => value.trim().isEmpty ? '用户名不能为空' : null,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: TextFormField(
                obscureText: true,
                controller: _passwordController,
                style: TextStyle(color: Colors.white, fontSize: 16.0),
                decoration: InputDecoration(
                    icon: Icon(ThirdIcons.password, size: 24.0, color: Colors.white),
                    labelText: '请输入密码',
                    labelStyle: TextStyle(color: Colors.white),
                    helperStyle: TextStyle(color: Colors.white)),
                validator: (value) => value.trim().length < 6 ? '密码长度不能小于6位' : null,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: SizedBox(
                // 主要用于使 RaisedButton 和上层容器同宽
                width: MediaQuery.of(context).size.width,
                child: RaisedButton(
                    color: Colors.pink,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4.0))),
                    onPressed: _login,
                    child: Text(
                      '登录',
                      style: TextStyle(color: Colors.white, fontSize: 20.0),
                    )),
              ),
            )
          ],
        ));
  }
}

/// 注册界面
class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  _register() {
    FocusScope.of(context).requestFocus(FocusNode());
    if (_formKey.currentState.validate()) {
      var username = _usernameController.value.text;

      if (username != 'kuky')
        Fluttertoast.showToast(msg: '注册成功');
      else
        Fluttertoast.showToast(msg: '用户名已存在');
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: TextFormField(
                controller: _usernameController,
                style: TextStyle(color: Colors.white, fontSize: 16.0),
                decoration: InputDecoration(
                    icon: Icon(ThirdIcons.username, size: 24.0, color: Colors.white),
                    labelText: '请输入用户名',
                    labelStyle: TextStyle(color: Colors.white),
                    helperStyle: TextStyle(color: Colors.white)),
                validator: (value) => value.trim().isEmpty ? '用户名不能为空' : null,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: TextFormField(
                obscureText: true,
                controller: _passwordController,
                style: TextStyle(color: Colors.white, fontSize: 16.0),
                decoration: InputDecoration(
                    icon: Icon(ThirdIcons.password, size: 24.0, color: Colors.white),
                    labelText: '请输入密码',
                    labelStyle: TextStyle(color: Colors.white),
                    helperStyle: TextStyle(color: Colors.white)),
                validator: (value) => value.trim().length < 6 ? '密码长度不能小于6位' : null,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: TextFormField(
                obscureText: true,
                controller: _confirmController,
                style: TextStyle(color: Colors.white, fontSize: 16.0),
                decoration: InputDecoration(
                    icon: Icon(ThirdIcons.password, size: 24.0, color: Colors.white),
                    labelText: '请确认密码',
                    labelStyle: TextStyle(color: Colors.white),
                    helperStyle: TextStyle(color: Colors.white)),
                validator: (value) => value.trim() != _passwordController.value.text ? '两次输入密码不相同' : null,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: RaisedButton(
                    color: Colors.pink,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4.0))),
                    onPressed: _register,
                    child: Text(
                      '注册',
                      style: TextStyle(color: Colors.white, fontSize: 20.0),
                    )),
              ),
            )
          ],
        ));
  }
}
