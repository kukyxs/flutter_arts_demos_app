import 'dart:ui';

import 'package:flutter/material.dart';

typedef GroupChangeCallback(int index);

typedef int SortRule(String a, String b);

class SuspensionListView extends StatefulWidget {
  final double itemExtent;
  final double headExtent;
  final List<SuspensionView> items;
  final ScrollPhysics physics;
  final TextStyle headStyle;
  final Decoration headDecoration;
  final EdgeInsetsGeometry headPadding;
  final Alignment headAlign;
  final Widget itemDivider;
  final double divideHeight;
  final GroupChangeCallback callback;
  final SortRule sortRule;

  SuspensionListView({
    @required this.itemExtent,
    @required this.headExtent,
    @required this.items,
    this.physics,
    this.headStyle,
    this.headDecoration,
    this.headPadding,
    this.headAlign,
    this.itemDivider,
    this.divideHeight = 0.0,
    this.callback,
    this.sortRule,
  });

  @override
  _SuspensionListViewState createState() => _SuspensionListViewState();
}

class _SuspensionListViewState extends State<SuspensionListView> {
  var _children = <Widget>[];
  var _keys = <String>[];
  var _groups = <String, List<SuspensionView>>{};
  var _listController = ScrollController();
  var _needHeader = true;
  var _keyRange = <double>[];
  var _selectedIndex = 0;

  @override
  void initState() {
    super.initState();

    widget.items.forEach((suspensionView) {
      if (!_keys.contains(suspensionView.tagRule)) {
        _keys.add(suspensionView.tagRule);
        _groups.putIfAbsent(suspensionView.tagRule, () => <SuspensionView>[]);
      }

      var list = _groups[suspensionView.tagRule] ?? <SuspensionView>[];
      list.add(suspensionView);
    });

    if (widget.sortRule != null) {
      _keys.sort(widget.sortRule);
    }

    _keys.forEach((key) {
      var header = Container(
        height: widget.headExtent,
        alignment: widget.headAlign ?? Alignment.centerLeft,
        padding: widget.headPadding ?? const EdgeInsets.all(8.0),
        decoration: widget.headDecoration ?? BoxDecoration(color: Colors.grey[300]),
        child: Text(key, style: widget.headStyle),
      );

      _children.add(header);

      var groupList = _groups[key];

      _keyRange.add(widget.headExtent +
          groupList.length * widget.itemExtent +
          (_keyRange.isEmpty ? 0.0 : _keyRange.last) +
          (groupList.length - 1) * widget.divideHeight);

      for (var index = 0; index < groupList.length; index++) {
        var content = SizedBox(
          height: widget.itemExtent,
          child: groupList[index].itemLayout,
        );

        _children.add(content);

        if (widget.itemDivider != null && index != groupList.length - 1) {
          _children.add(widget.itemDivider);
        }
      }
    });

    _listController.addListener(() {
      setState(() => _needHeader = _listController.offset >= 0);

      for (var index = 0; index < _keyRange.length; index++) {
        var min = index == 0 ? 0 : _keyRange[index - 1];
        var max = _keyRange[index];

        if (_listController.offset < max && _listController.offset >= min && _selectedIndex != index) {
          setState(() {
            _selectedIndex = index;
          });

          if (widget.callback != null) {
            widget.callback(_selectedIndex);
            break;
          }
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _listController.dispose();
  }

  @override
  void didUpdateWidget(SuspensionListView oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        alignment: Alignment.centerRight,
        children: <Widget>[
          ListView(
            physics: widget.physics,
            controller: _listController,
            children: _children,
          ),
          Positioned(
            top: 0.0,
            left: 0.0,
            child: _needHeader
                ? Container(
                    width: MediaQuery.of(context).size.width,
                    height: widget.headExtent,
                    alignment: widget.headAlign,
                    padding: widget.headPadding,
                    decoration: widget.headDecoration,
                    child: Text(_keys[_selectedIndex], style: widget.headStyle),
                  )
                : Container(
                    color: Colors.transparent,
                    height: widget.headExtent,
                  ),
          ),
        ],
      ),
    );
  }
}

abstract class SuspensionView {
  Object data;

  SuspensionView(this.data) : assert(data != null);

  String get tagRule;

  Widget get itemLayout;
}
