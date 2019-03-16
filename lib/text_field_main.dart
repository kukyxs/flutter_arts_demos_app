import 'package:flutter/material.dart';

void main() => runApp(DemoApp());

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

class _HomePageState extends State<HomePage> {
  // 可以传入初始值
  TextEditingController _editController = TextEditingController();
  FocusNode _editNode = FocusNode();
  String _content = '';
  String _spyContent = '';

  @override
  void initState() {
    super.initState();

    _editNode.addListener(() {
      print('edit has focus? => ${_editNode.hasFocus}');
    });
  }

  @override
  void dispose() {
    // 记得销毁
    _editController.dispose();
    _editNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Input Content'),
      ),
      body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            children: <Widget>[
              TextField(
                controller: _editController,
                focusNode: _editNode,
                decoration: InputDecoration(
                    icon: Icon(Icons.phone_iphone, color: Theme.of(context).primaryColor),
                    labelText: '请输入手机号',
                    helperText: '手机号',
                    hintText: '手机号...在这儿输入呢'),
                keyboardType: TextInputType.number,
                // 输入类型为数字类型
                textInputAction: TextInputAction.done,
                style: TextStyle(color: Colors.redAccent, fontSize: 18.0),
                textDirection: TextDirection.ltr,
                maxLength: 11,
                // 最大长度为 11
                maxLengthEnforced: true,
                // 超过长度的不显示
                onChanged: (v) {
                  // 输入的内容发生改变会调用
                  setState(() => _spyContent = v);
                },
                onSubmitted: (s) {
                  // 点击确定按钮时候会调用
                  setState(() => _spyContent = _editController.value.text);
                },
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: RaisedButton(
                      onPressed: () {
                        // 获取输入的内容
                        setState(() => _content = _editController.value.text);
                        // 清理输入内容
                        _editController.clear();
                        setState(() => _spyContent = '');
                      },
                      child: Text('获取输入内容'))),
              // 展示输入的内容，点击按钮会显示
              Text(_content.isNotEmpty ? '获取到输入内容: $_content' : '还未获取到任何内容...'),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                // 监听输入内容的变化，会跟随输入的内容进行改变
                child: Text('我是文字内容监听：$_spyContent'),
              )
            ],
          )),
    );
  }
}
