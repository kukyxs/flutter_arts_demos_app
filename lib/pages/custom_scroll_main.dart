import 'package:flutter/material.dart';

class CustomScrollDemoPage extends StatelessWidget {
  final List<String> letters = [
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
    'L',
    'M',
    'N',
    'O',
    'P',
    'Q',
    'R',
    'S',
    'T',
    'U',
    'V',
    'W',
    'X',
    'Y',
    'Z'
  ];

  final List<Color> colors = [Colors.red, Colors.green, Colors.blue, Colors.pink, Colors.yellow, Colors.deepPurple];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CustomScrollDemo'),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverGrid(
              delegate: SliverChildBuilderDelegate(
                  (_, index) => InkWell(
                        child: Image.asset(
                          'images/ali.jpg', /*color: colors[index], colorBlendMode: BlendMode.srcIn*/
                        ),
                        onTap: () {},
                      ),
                  childCount: 8),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4, mainAxisSpacing: 10.0, crossAxisSpacing: 10.0)),
          SliverToBoxAdapter(
              child: Container(
                  color: Colors.black12,
                  margin: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Column(children: <Widget>[
                    Divider(height: 2.0, color: Colors.black54),
                    Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        Image.asset('images/app_bar_hor.jpg', fit: BoxFit.cover),
                        Text('我是一些别的东西..例如广告', textScaleFactor: 1.5, style: TextStyle(color: Colors.red))
                      ],
                    ),
                    Divider(height: 2.0, color: Colors.black54),
                  ], mainAxisAlignment: MainAxisAlignment.spaceBetween),
                  alignment: Alignment.center)),
          SliverFixedExtentList(
              delegate: SliverChildBuilderDelegate(
                  (_, index) => InkWell(
                        child: Container(
                          child: Text(letters[index] * 10,
                              style: TextStyle(color: colors[index % colors.length], letterSpacing: 2.0),
                              textScaleFactor: 1.5),
                          alignment: Alignment.center,
                        ),
                        onTap: () {},
                      ),
                  childCount: letters.length),
              itemExtent: 60.0)
        ],
      ),
    );
  }
}
