import 'dart:async';

import 'package:flutter_arts_demos_app/bloc/bloc_provider.dart';
import 'package:rxdart/rxdart.dart';

class CounterBloc extends BaseBloc {
  int _count = 0;

  int get count => _count;

  // rx
//  BehaviorSubject<int> _counterController = BehaviorSubject();
//
//  Observable<int> get counterStream => _counterController.stream;
//
//  void dispatch(int value) {
//    _count = value;
//    _counterController.add(_count);
//  }

  // stream
  StreamController<int> _countController = StreamController.broadcast();

  Stream<int> get countStream => _countController.stream;

  void dispatch(int value) {
    _count = value;
    _countController.sink.add(_count);
  }

  @override
  void dispose() {
    _countController.close();
  }
}
