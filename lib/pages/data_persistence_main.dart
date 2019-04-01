import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataPersistenceDemoPage extends StatefulWidget {
  @override
  DataPersistenceDemoPageState createState() => DataPersistenceDemoPageState();
}

class DataPersistenceDemoPageState extends State<DataPersistenceDemoPage> {
  // 用于单选按钮的选项
  final List<String> _radioText = ['TemporaryDirectory', 'ApplicationDocumentsDirectory', 'ExternalStorageDirectory'];
  final List<String> _radioDescriptions = [
    'Path to the temporary directory on the device.',
    'Path to a directory where the application place files that are private to application',
    'Path to a directory where the application access top level storage.'
  ];

  String _fileContent = '';
  String _shareContent = '';
  String _currentValue;
  var _editController = TextEditingController();
  var _shareKeyController = TextEditingController();
  var _shareValueController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _currentValue = _radioText[0];
  }

  @override
  void dispose() {
    _editController.dispose();
    _shareKeyController.dispose();
    _shareValueController.dispose();
    super.dispose();
  }

  // 获取文件的存储路径，根据选择来获取
  Future<String> _getFilePath() async {
    String dir = (await getTemporaryDirectory()).path; // 默认为临时目录

    switch (_currentValue) {
      case 'TemporaryDirectory':
        dir = (await getTemporaryDirectory()).path;
        break;
      case 'ApplicationDocumentsDirectory':
        dir = (await getApplicationDocumentsDirectory()).path; // 缓存目录
        break;
      case 'ExternalStorageDirectory':
        if (Platform.isAndroid) {
          dir = (await getExternalStorageDirectory()).path; // 外部存储目录，仅对 android 有效
        } else if (Platform.isIOS) {
          dir = (await getTemporaryDirectory()).path; // iOS 不存在外部存储，设为临时目录
        }
        break;
    }
    return '$dir/store.txt';
  }

  // 如果写入外部内存需要读写权限
  void _writeTextIntoFile() async {
    if (_currentValue == _radioText[2]) {
      PermissionStatus status = await PermissionHandler().checkPermissionStatus(PermissionGroup.storage);
      if (status == PermissionStatus.granted)
        _writeContent();
      else if (status == PermissionStatus.disabled)
        Fluttertoast.showToast(msg: '未打开相关权限');
      else
        PermissionHandler().requestPermissions([PermissionGroup.storage]);
    } else
      _writeContent();
  }

  void _writeContent() async {
    // 写入文本操作
    var text = _editController.value.text; // 获取文本框的内容
    File file = File(await _getFilePath()); // 获取相应的文件

    if (text == null || text.isEmpty) {
      Fluttertoast.showToast(msg: '请输入内容'); // 内容为空，则不写入并提醒
    } else {
      // 内容不空，则判断是否已经存在，存在先删除，重新创建后写入信息
      if (await file.exists()) file.deleteSync();
      file.createSync();
      file.writeAsStringSync(text);
      _editController.clear(); // 写入文件后清空输入框信息
    }
  }

  void _readTextFromFile() async {
    // 读取文本操作
    File file = File(await _getFilePath());
    if (await file.exists()) {
      setState(() => _fileContent = file.readAsStringSync()); // 文件存在则直接显示文本信息
    } else {
      setState(() => _fileContent = ''); // 文件不存在则清空显示文本信息，并提示
      Fluttertoast.showToast(msg: '文件还未创建，请先通过写入信息来创建文件');
    }
  }

  void _writeIntoShare() async {
    var shareKey = _shareKeyController.value.text;
    var shareContent = _shareValueController.value.text;

    if (shareKey == null || shareKey.isEmpty) {
      Fluttertoast.showToast(msg: '请输入 key');
    } else if (shareContent == null || shareContent.isEmpty) {
      Fluttertoast.showToast(msg: '请输入保存的内容');
    } else {
      var sp = await SharedPreferences.getInstance();
      sp.setString(shareKey, shareContent);
    }
  }

  void _readFromShare() async {
    var shareKey = _shareKeyController.value.text;

    if (shareKey == null || shareKey.isEmpty) {
      Fluttertoast.showToast(msg: '请输入 key');
    } else {
      var sp = await SharedPreferences.getInstance();
      var value = sp.getString(shareKey);

      if (value == null) {
        Fluttertoast.showToast(msg: '未找到该 key');
        setState(() => _shareContent = '');
      } else {
        setState(() => _shareContent = value);
      }
    }
  }

  Widget _fileIoPart() {
    return Card(
      margin: const EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
      child: Column(children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text('File IO', style: TextStyle(fontSize: 20.0, color: Theme.of(context).primaryColor)),
        ),
        // RadioList 是单选按钮部件，通过选择不同的情况，创建不同目录的文件
        RadioListTile(
            value: _radioText[0],
            title: Text(_radioText[0]),
            subtitle: Text(_radioDescriptions[0]),
            groupValue: _currentValue,
            onChanged: ((value) {
              setState(() => _currentValue = value);
            })),
        RadioListTile(
            value: _radioText[1],
            title: Text(_radioText[1]),
            subtitle: Text(_radioDescriptions[1]),
            groupValue: _currentValue,
            onChanged: ((value) {
              setState(() => _currentValue = value);
            })),
        RadioListTile(
            value: _radioText[2],
            title: Text(_radioText[2]),
            subtitle: Text(_radioDescriptions[2]),
            groupValue: _currentValue,
            onChanged: ((value) {
              setState(() => _currentValue = value);
            })),
        Padding(
          padding: const EdgeInsets.all(12.0),
          // 用于写入文本信息
          child: TextField(
            controller: _editController,
            decoration: InputDecoration(labelText: '输入存储的文本内容', icon: Icon(Icons.text_fields)),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 12.0),
          width: MediaQuery.of(context).size.width,
          child: RaisedButton(
            onPressed: _writeTextIntoFile,
            child: Text('写入文件信息'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[Text('文件内容：'), Expanded(child: Text(_fileContent, softWrap: true))],
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 12.0),
          width: MediaQuery.of(context).size.width,
          child: RaisedButton(
            onPressed: _readTextFromFile,
            child: Text('读取文件信息'),
          ),
        ),
      ]),
    );
  }

  Widget _sharedPart() {
    return Card(
        margin: const EdgeInsets.all(8.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(12.0),
              child:
                  Text('Shared Preferences', style: TextStyle(fontSize: 20.0, color: Theme.of(context).primaryColor)),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12.0, 0, 12.0, 12.0),
              // 用于设置 key 信息
              child: TextField(
                controller: _shareKeyController,
                decoration: InputDecoration(labelText: '输入 share 存储的 key', icon: Icon(Icons.lock_outline)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12.0, 0, 12.0, 12.0),
              // 用于写入文本信息
              child: TextField(
                controller: _shareValueController,
                decoration: InputDecoration(labelText: '输入 share 存储的 value', icon: Icon(Icons.text_fields)),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 12.0),
              width: MediaQuery.of(context).size.width,
              child: RaisedButton(
                onPressed: _writeIntoShare,
                child: Text('写入 share'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[Text('share 存储内容：'), Expanded(child: Text(_shareContent, softWrap: true))],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 12.0),
              width: MediaQuery.of(context).size.width,
              child: RaisedButton(
                onPressed: _readFromShare,
                child: Text('读取 share'),
              ),
            ),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FileIO Demo'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[_fileIoPart(), _sharedPart()],
        ),
      ),
    );
  }
}
