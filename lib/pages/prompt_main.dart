import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class PromptDemoPage extends StatefulWidget {
  @override
  _PromptDemoPageState createState() => _PromptDemoPageState();
}

class _PromptDemoPageState extends State<PromptDemoPage> {
  var count = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  increase() {
    setState(() => count++);
  }

  decrease() {
    setState(() => count--);
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
              title: Text('这是个标题...'),
              titleTextStyle: TextStyle(color: Colors.purple),
              content: Text('我是内容，我是内容，我是内容，我是内容，我是内容，我是内容'),
              contentTextStyle: TextStyle(color: Colors.yellow),
              backgroundColor: CupertinoColors.white,
              elevation: 8.0,
              semanticLabel: 'Label',
              shape: Border.all(),
              actions: <Widget>[
                FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Action1')),
                FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Action2')),
                FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Action3')),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Prompt Demo'),
      ),
      body: Column(children: <Widget>[
        Text('当前值：$count', style: TextStyle(fontSize: 20.0)),
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
//          RaisedButton(onPressed: _showAlertDialog, child: Text('Show AlertDialog')),
//          RaisedButton(onPressed: _showAlertDialog, child: Text('Show AlertDialog')),
        ]))
      ]),
      floatingActionButton: Builder(
          builder: (context) => FloatingActionButton(onPressed: () => _changeValue(context), child: Icon(Icons.send))),
    );
  }
}
