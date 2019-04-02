import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class HttpDemoPage extends StatefulWidget {
  @override
  _HttpDemoPageState createState() => _HttpDemoPageState();
}

class _HttpDemoPageState extends State<HttpDemoPage> {
  static const _USER_ME_URL = 'https://randomuser.me/api/';
  String _netBack = '';

  @override
  void initState() {
    super.initState();
  }

  _httpClientRequest() async {
    HttpClient client;
    try {
      client = HttpClient();
      HttpClientRequest request = await client.getUrl(Uri.parse(_USER_ME_URL));
      request.headers.add('user-agent',
          'Mozilla/5.0 (iPhone; CPU iPhone OS 10_3_1 like Mac OS X) AppleWebKit/603.1.30 (KHTML, like Gecko) Version/10.0 Mobile/14E304 Safari/602.1');
      HttpClientResponse response = await request.close();
      print('http headers: ${response.headers.toString()}');
      String strResponse = await response.transform(utf8.decoder).join();
      print('json: ${json.decode(strResponse)}');
      setState(() => _netBack = strResponse);
    } catch (e) {
      print('${e.toString()}');
      setState(() => _netBack = 'Fail');
    } finally {
      client.close();
    }
  }

  _dioRequest() async {
    BaseOptions options = BaseOptions(connectTimeout: 5000, receiveTimeout: 60000);
    Dio dio = Dio(options);

//    dio.interceptors.add(InterceptorsWrapper(onRequest: (opt) async => dio.resolve('{"fake": "fake data"}')));

//    dio.interceptors.add(InterceptorsWrapper(onRequest: (opt) async => dio.reject('{"fake": "fake data"}')));

    dio.interceptors.add(InterceptorsWrapper(onRequest: (opt) async {
      dio.interceptors.requestLock.lock();
      print('start: ${DateTime.now().millisecondsSinceEpoch}');
      await Future.delayed(Duration(milliseconds: 1000)).then((_) {
        Map params = opt.queryParameters;
        params.forEach((key, value) => opt.queryParameters[key] = '$value'.toLowerCase());
        dio.interceptors.requestLock.unlock();
      });
      print('end: ${DateTime.now().millisecondsSinceEpoch}');
      opt.headers['authorization'] = 'token';
      return opt;
    }, onResponse: (resp) {
      resp.data = '${'${resp.data}'.split(', info').first}}';
      return resp;
    }, onError: (error) {
      return error;
    }));

    Response response = await dio.get(_USER_ME_URL, queryParameters: {'a': 'AAA', 'b': 'BbBbBb'});
    print(response.data);
    print(response.request.headers);
    print(response.request.queryParameters);
    setState(() => _netBack = response.data.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Http Demo'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: RaisedButton(onPressed: _dioRequest, child: Text('Request')),
            ),
            Text(_netBack)
          ],
        ),
      ),
    );
  }
}
