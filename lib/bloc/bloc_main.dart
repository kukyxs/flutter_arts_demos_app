import 'package:flutter/material.dart';

import 'bloc_provider.dart';
import 'counter_bloc.dart';

int initCount = 0;

void main() async {
  Future.delayed(Duration(seconds: 1)).then((val) {
    initCount = 3;

    runApp(MaterialApp(
      home: BlocProvider(child: BlocMain(), bloc: CounterBloc()),
    ));
  });
}

class BlocMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CounterBloc _counterBloc = BlocProvider.of(context);

    return Scaffold(
      body: StreamBuilder(
          builder: (context, countSnapshot) => StreamBuilder(
                builder: (context, textSnapshot) => Center(
                        child: Column(
                      children: <Widget>[
                        ActionChip(
                            label: Text('${countSnapshot.data}'),
                            onPressed: () {
                              _counterBloc.dispatch(countSnapshot.data + 1);
                            }),
                        Text('${textSnapshot.data}')
                      ],
                    )),
                initialData: '',
                stream: _counterBloc.textStream,
              ),
          initialData: initCount,
          stream: _counterBloc.counterStream),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _counterBloc.dispatchText('New');
        },
        child: Icon(Icons.chat),
      ),
    );
  }
}
