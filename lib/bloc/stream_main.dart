import 'package:flutter/material.dart';

import 'bloc_provider.dart';
import 'counter_bloc.dart';

void main() => runApp(StreamApp());

class StreamApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: StreamHome(),
        ),
        bloc: CounterBloc());
  }
}

class StreamHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CounterBloc _bloc = BlocProvider.of<CounterBloc>(context);
    return Scaffold(
      body: SafeArea(
          child: Container(
        alignment: Alignment.center,
        child: StreamBuilder(
          initialData: _bloc.count,
          stream: _bloc.countStream,
          builder: (_, snapshot) => Text('${snapshot.data}', style: TextStyle(fontSize: 20.0)),
        ),
      )),
      floatingActionButton:
          FloatingActionButton(onPressed: () => _bloc.dispatch(_bloc.count + 1), child: Icon(Icons.add)),
    );
  }
}

//class StreamHome extends StatefulWidget {
//  @override
//  _StreamHomeState createState() => _StreamHomeState();
//}
//
//class _StreamHomeState extends State<StreamHome> {
//  // 定义一个全局的 `StreamController`
//  StreamController<int> _controller = StreamController.broadcast();
//  // `sink` 用于传入新的数据
//  Sink<int> _sink;
//  int _counter = 0;
//
////  StreamSubscription<int> _subscription;
//
//  @override
//  void initState() {
//    super.initState();
//
//    _sink = _controller.sink;
//
////    _subscription = _controller.stream.where((value) => value > 10).take(5).listen((data) => print('Listen: $data'));
////
////    List.generate(20, (index) => _sink.add(index));
////
////    _sink.add('A');
////    _sink.add(11);
////    _subscription.pause();
////    _sink.add(11.16);
////    _subscription.resume();
////    _sink.add([1, 2, 3]);
////    _sink.add({'a': 1, 'b': 2});
//  }
//
//  @override
//  void dispose() {
//    super.dispose();
//    // 需要销毁资源
//    _sink.close();
//    _controller.close();
////    _subscription.cancel();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      body: SafeArea(
//          child: Container(
//        alignment: Alignment.center,
//        child: StreamBuilder(
//          builder: (_, snapshot) => Text('${snapshot.data}', style: TextStyle(fontSize: 24.0)),
//          stream: _controller.stream, // stream 在 StreamBuilder 销毁的时候会自动销毁
//          initialData: _counter,
//        ),
//      )),
//      // 通过 `sink` 传入新的数据，去通知 `stream` 更新到 builder 中
//      floatingActionButton: FloatingActionButton(
//        onPressed: () => _sink.add(_counter++),
//        child: Icon(Icons.add),
//      ),
//    );
//  }
//}
