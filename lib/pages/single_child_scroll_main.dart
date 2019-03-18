import 'package:flutter/material.dart';

class SingleChildScrollDemoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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

    return Scaffold(
      appBar: AppBar(
        title: Text('Single Child Demo'),
      ),

//      body: SingleChildScrollView(child: Text('一段又臭又长的文字' * 1000, softWrap: true)),

//      垂直滑动 demo
//      body: SingleChildScrollView(
//          child: Center(
//        child: Column(
//          children: List.generate(
//              letters.length,
//              (index) => Padding(
//                    padding: const EdgeInsets.symmetric(vertical: 4.0),
//                    child: Text(letters[index], style: TextStyle(fontSize: 18.0)),
//                  )),
//        ),
//      )),

      // 横向滑动
      body: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Center(
            child: Row(
              children: List.generate(
                  letters.length,
                  (index) => Container(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0),
                        child: Text(letters[index], style: TextStyle(fontSize: 18.0)),
                      ),
                      width: 30.0)),
            ),
          )),
    );
  }
}
