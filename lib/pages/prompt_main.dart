import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PromptDemoPage extends StatefulWidget {
  @override
  _PromptDemoPageState createState() => _PromptDemoPageState();
}

class _PromptDemoPageState extends State<PromptDemoPage> {
  var _count = 0;
  var _genders = ['男', '女'];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  increase() {
    setState(() => _count++);
  }

  decrease() {
    setState(() => _count--);
  }

  _changeValue(BuildContext context) {
    increase();
    Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('当前值已修改'),
        action: SnackBarAction(label: '撤销', onPressed: decrease),
        duration: Duration(milliseconds: 2000)));
  }

  _showBottomSheet(BuildContext context) {
    showBottomSheet(
      context: context,
      builder: (context) => ListView(
              // 生成一个列表选择器
              children: List.generate(
            20,
            (index) => InkWell(
                child: Container(alignment: Alignment.center, height: 60.0, child: Text('Item ${index + 1}')),
                onTap: () {
                  print('tapped item ${index + 1}');
                  Navigator.pop(context);
                }),
          )),
    );
  }

  _showModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
            child: ListView(
                children: List.generate(
              2,
              (index) => InkWell(
                  child: Container(alignment: Alignment.center, height: 60.0, child: Text('Item ${index + 1}')),
                  onTap: () {
                    print('tapped item ${index + 1}');
                    Navigator.pop(context);
                  }),
            )),
            height: 120,
          ),
    );
  }

  _showAlertDialog() {
    showDialog(
        // 设置点击 dialog 外部不取消 dialog
        barrierDismissible: false,
        context: context,
        builder: (context) => AlertDialog(
              title: Text('我是个标题...嗯，标题..'),
              titleTextStyle: TextStyle(color: Colors.purple),
              // 标题文字样式
              content: Text(r'我是内容\(^o^)/~, 我是内容\(^o^)/~, 我是内容\(^o^)/~'),
              contentTextStyle: TextStyle(color: Colors.green),
              // 内容文字样式
              backgroundColor: CupertinoColors.white,
              elevation: 8.0,
              // 投影的阴影高度
              semanticLabel: 'Label',
              // 这个用于无障碍下弹出 dialog 的提示
              shape: Border.all(),
              // dialog 的操作按钮，actions 的个数尽量控制不要过多，否则会溢出 `Overflow`
              actions: <Widget>[
                FlatButton(onPressed: increase, child: Text('点我增加')),
                FlatButton(onPressed: decrease, child: Text('点我减少')),
                // 关闭 dialog 也需要通过 Navigator 进行操作
                FlatButton(onPressed: () => Navigator.pop(context), child: Text('你点我试试.')),
              ],
            ));
  }

  _showSimpleDialog() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => SimpleDialog(
              title: Text('我是个比较正经的标题...\n选择你的性别'),
              children: _genders
                  .map((gender) => InkWell(
                        child: Container(height: 40.0, child: Text(gender), alignment: Alignment.center),
                        onTap: () {
                          Navigator.pop(context);
                          Fluttertoast.showToast(msg: '你选择的性别是 $gender');
                        },
                      ))
                  .toList(),
            ));
  }

  _showAboutDialog() {
//    showDialog(
//        barrierDismissible: false,
//        context: context,
//        builder: (context) => AboutDialog(
//              applicationName: 'Flutter 入门指北',
//              applicationVersion: '0.1.1',
//              applicationLegalese: 'Copyright: this is a copyright notice topically',
//              applicationIcon: Image.asset('images/app_icon.png', width: 40.0, height: 40.0),
//              children: <Widget>[Text('我是个比较正经的对话框内容...你可以随便把我替换成任何部件，只要你喜欢(*^▽^*)')],
//            ));

    showAboutDialog(
      context: context,
      applicationName: 'Flutter 入门指北',
      applicationVersion: '0.1.1',
      applicationLegalese: 'Copyright: this is a copyright notice topically',
      applicationIcon: Image.asset('images/app_icon.png', width: 40.0, height: 40.0),
      children: <Widget>[Text('我是个比较正经的对话框内容...你可以随便把我替换成任何部件，只要你喜欢(*^▽^*)')],
    );
  }

  _showStateDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        // 通过 StatefulBuilder 来保存 dialog 状态
        // builder 需要传入一个 BuildContext 和 StateSetter 类型参数
        // StateSetter 有一个 VoidCallback，修改状态的方法在这写
        builder: (context) => StatefulBuilder(
            builder: (context, dialogStateState) => SimpleDialog(
                  title: Text('我这边能实时修改状态值'),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                  children: <Widget>[
                    Text('当前的值是： $_count', style: TextStyle(fontSize: 18.0)),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: <Widget>[
                        RaisedButton(
                          // 通过 StatefulBuilder 的 StateSetter 来修改值
                          onPressed: () => dialogStateState(() => increase()),
                          child: Text('点我自增'),
                        ),
                        RaisedButton(
                          onPressed: () => dialogStateState(() => decrease()),
                          child: Text('点我自减'),
                        ),
                        RaisedButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('点我关闭'),
                        )
                      ]),
                    )
                  ],
                )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Prompt Demo'),
      ),
      body: Column(children: <Widget>[
        Text('当前值：$_count', style: TextStyle(fontSize: 20.0)),
        Expanded(
            child: ListView(padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0), children: <Widget>[
          // SnackBar 需要提供一个包含 context，但是 context 不能是 Scaffold 节点下的 context，所以需要通过 Builder 包裹一层
          Builder(builder: (context) => RaisedButton(onPressed: () => _changeValue(context), child: Text('修改当前值'))),
          // BottomSheet 的 context 也不能是 Scaffold 节点下的 context
          Builder(
              builder: (context) =>
                  RaisedButton(onPressed: () => _showBottomSheet(context), child: Text('BottomSheet'))),
          Builder(
              builder: (context) =>
                  RaisedButton(onPressed: () => _showModalBottomSheet(context), child: Text('ModaBottomSheet'))),
          RaisedButton(onPressed: _showAlertDialog, child: Text('AlertDialog')),
          RaisedButton(onPressed: _showSimpleDialog, child: Text('SimpleDialog')),
          RaisedButton(onPressed: _showAboutDialog, child: Text('AboutDialog')),
          RaisedButton(onPressed: _showStateDialog, child: Text('DialogState'))
        ]))
      ]),
      floatingActionButton: Builder(
          builder: (context) => FloatingActionButton(onPressed: () => _changeValue(context), child: Icon(Icons.send))),
    );
  }
}
