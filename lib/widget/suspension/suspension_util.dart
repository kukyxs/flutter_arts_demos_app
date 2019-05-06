import 'package:flutter_arts_demos_app/widget/suspension/suspension_list.dart';
import 'package:flutter_arts_demos_app/widget/suspension/suspension_view.dart';

class SuspensionUtils {
  static Map<String, List<Object>> getSuspensionKeyRanges(
    List<SuspensionView> items,
    double itemExtent,
    double headExtent, {
    double divideHeight = 0,
    SortRule rule,
  }) {
    var _keys = <String>[];
    var _ranges = <double>[];
    var _groups = <String, List<SuspensionView>>{};
    var result = <String, List<Object>>{};

    items.forEach((suspensionView) {
      if (!_keys.contains(suspensionView.tagRule)) {
        _keys.add(suspensionView.tagRule);
        _groups.putIfAbsent(suspensionView.tagRule, () => <SuspensionView>[]);
      }

      var list = _groups[suspensionView.tagRule] ?? <SuspensionView>[];
      list.add(suspensionView);
    });

    if (rule != null) {
      _keys.sort(rule);
    }

    _ranges.add(0);

    _keys.forEach((key) {
      var groupList = _groups[key];
      _ranges.add(headExtent + groupList.length * itemExtent + (_ranges.isEmpty ? 0.0 : _ranges.last) + (groupList.length - 1) * divideHeight);
    });

    result['keys'] = _keys;
    result['ranges'] = _ranges;

    return result;
  }
}
