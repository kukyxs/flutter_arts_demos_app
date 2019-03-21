import 'dart:async';

import 'package:flutter_arts_demos_app/bloc/bloc_provider.dart';
import 'package:rxdart/rxdart.dart';

class CounterBloc extends BaseBloc {
  BehaviorSubject<int> _counterController = BehaviorSubject();

  Observable<int> get counterStream => _counterController.stream;

  void dispatch(int value) => _counterController.add(value);

  StreamController<String> _textController = StreamController.broadcast();

  Stream<String> get textStream => _textController.stream;

  void dispatchText(String text) => _textController.sink.add(text);

  CounterBloc() {
    Future.delayed(Duration(seconds: 1)).then((_) => dispatch(1));

    Future.delayed(Duration(milliseconds: 500)).then((_) => dispatchText('hello~'));
  }

  @override
  void dispose() {
    _counterController?.close();
    _textController?.close();
  }
}
