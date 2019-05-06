import 'package:flutter/material.dart';
import 'package:flutter_arts_demos_app/widget/suspension_list.dart';

void main() {
  runApp(TestApp());
}

class TestApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TestHome(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class TestHome extends StatefulWidget {
  @override
  _TestHomeState createState() => _TestHomeState();
}

class _TestHomeState extends State<TestHome> {
  final list = [
    'AAA',
    'BBB',
    'BBB',
    'BCV',
    'UYT',
    'ABC',
    'ABC',
    'ANM',
    'GHI',
    'GHI',
    'GJK',
    'UYT',
    'UYT',
    'ZKK',
    'BBB',
    'ZKK',
    'UYT',
    'OOO',
    'OOO',
    'GHY',
    'GHY',
    'REG',
    'CNI',
    'CNI',
    'GHY',
    'SUU',
    'OOO',
    'SUU',
    'SUU',
    'ZKK',
    'ZKK',
    'ADD',
    'REG',
    'REG',
    'CNI',
    'CNI',
  ];

  final keys = ['A', 'B', 'C', 'G', 'O', 'R', 'S', 'U', 'Z'];

  var clickValue = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 50.0,
              child: ListView.separated(
                  itemBuilder: (_, index) => InkWell(
                        child: Container(
                          height: 30.0,
                          color: clickValue == index ? Colors.grey[200] : Colors.white,
                          alignment: Alignment.center,
                          child: Text('${keys[index]}'),
                        ),
                        onTap: () {

                        },
                      ),
                  separatorBuilder: (_, index) => Divider(
                        height: 1,
                        color: Colors.red,
                      ),
                  itemCount: keys.length),
            ),
            VerticalDivider(width: 1.0, color: Colors.grey),
            Expanded(
                child: SuspensionListView(
              itemExtent: 50.0,
              headExtent: 30.0,
              physics: BouncingScrollPhysics(),
              items: list.map((str) => StrSuspensionView(str)).toList(),
              headAlign: Alignment.centerLeft,
              headPadding: EdgeInsets.symmetric(horizontal: 12.0),
              headDecoration: BoxDecoration(color: Colors.grey[300]),
              itemDivider: Divider(height: 1.0, color: Colors.grey[300]),
              divideHeight: 1.0,
              callback: (index) {
                setState(() {
                clickValue = index;
                });
              },
              sortRule: (a, b) => a.compareTo(b),
            ))
          ],
        ),
      ),
    );
  }
}

class StrSuspensionView extends SuspensionView {
  StrSuspensionView(String data) : super(data);

  @override
  Widget get itemLayout => Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
        child: Text(this.data),
      );

  @override
  String get tagRule => (data as String).trimLeft().substring(0, 1).toUpperCase();
}
