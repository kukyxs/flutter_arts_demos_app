import 'package:flutter/material.dart';

class GridViewDemoPage extends StatelessWidget {
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

  final List<Color> colors = [Colors.red, Colors.green, Colors.blue, Colors.pink];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GridView Demo'),
      ),

//      body: GridView(
//        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5),
//        children: letters
//            .map((s) => InkWell(
//                  child: Center(child: Text(s)),
//                  onTap: () => print(s),
//                ))
//            .toList(),
//      ),

//      body: GridView(
//        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 100.0),
//        children: letters
//            .map((s) => InkWell(
//                  child: Center(child: Text(s)),
//                  onTap: () => print(s),
//                ))
//            .toList(),
//      ),

      body: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5),
          itemCount: letters.length,
          itemBuilder: (_, index) =>
              Container(color: colors[index % 4], child: Text(letters[index]), alignment: Alignment.center)),

//      body: GridView.custom(
//          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5, childAspectRatio: 0.5),
//          childrenDelegate: SliverChildBuilderDelegate(
//              (_, index) => Container(
//                  color: colors[index % 4],
//                  child: Center(
//                    child: Text(letters[index]),
//                  )),
//              childCount: letters.length)),

//      body: GridView.count(
//          crossAxisCount: 5,
//          childAspectRatio: 2.0,
//          children: List.generate(
//              letters.length,
//              (index) => Container(
//                    alignment: Alignment.center,
//                    color: colors[index % 4],
//                    child: Text(letters[index]),
//                  ))),

//      body: GridView.extent(
//          maxCrossAxisExtent: 80.0,
//          children: List.generate(
//              letters.length,
//              (index) => Container(
//                    alignment: Alignment.center,
//                    color: colors[index % 4],
//                    child: Text(letters[index]),
//                  ))),
    );
  }
}
