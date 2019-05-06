import 'package:flutter/material.dart';

import 'package:flutter_arts_demos_app/widget/flutter_suspension.dart';

class SuspensionPage extends StatefulWidget {
  @override
  _SuspensionPageState createState() => _SuspensionPageState();
}

class _SuspensionPageState extends State<SuspensionPage> {
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

  List<String> _keys;
  List<double> _ranges;

  var _clickValue = 0;
  var _scrollController = ScrollController();
  var _itemExtent = 50.0;
  var _headExtent = 30.0;
  var _dividerExtent = 1.0;
  var _rule = (String a, String b) => a.compareTo(b);
  List<SuspensionView> _suspensions;

  @override
  void initState() {
    super.initState();
    _suspensions = list.map((str) => StrSuspensionView(str)).toList();
    var result = SuspensionUtils.getSuspensionKeyRanges(_suspensions, _itemExtent, _headExtent, divideHeight: _dividerExtent, rule: _rule);
    _keys = result['keys'];
    _ranges = result['ranges'];
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Suspension Page'),
      ),
      body: Row(
        children: <Widget>[
          SizedBox(
            width: 50.0,
            child: ListView.separated(
                itemBuilder: (_, index) => InkWell(
                      child: Container(
                        height: 30.0,
                        color: _clickValue == index ? Colors.grey[200] : Colors.white,
                        alignment: Alignment.center,
                        child: Text('${_keys[index]}'),
                      ),
                      onTap: () {
                        _scrollController.animateTo(_ranges[index], duration: Duration(milliseconds: 300), curve: Curves.linear);
                      },
                    ),
                separatorBuilder: (_, index) => Divider(
                      height: 1,
                      color: Colors.red,
                    ),
                itemCount: _keys.length),
          ),
          VerticalDivider(width: 1.0, color: Colors.grey),
          Expanded(
              child: SuspensionListView(
            itemExtent: _itemExtent,
            headExtent: _headExtent,
            physics: ScrollPhysics(),
            scrollController: _scrollController,
            items: _suspensions,
            headAlign: Alignment.centerLeft,
            headPadding: EdgeInsets.symmetric(horizontal: 12.0),
            headDecoration: BoxDecoration(color: Colors.grey[300]),
            itemDivider: Divider(height: _dividerExtent, color: Colors.red[400]),
            divideHeight: _dividerExtent,
            callback: (index) {
              setState(() {
                _clickValue = index;
              });
            },
            sortRule: _rule,
          ))
        ],
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
