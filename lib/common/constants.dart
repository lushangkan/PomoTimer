import 'package:tuple/tuple.dart';

import 'attribute.dart';

class Constants {

  /// 专注时间范围
  /// Attribute: Tuple2<min, max>
  static final Map<Attribute, Tuple2<int, int>> timeRange = {
    Attribute.focus: const Tuple2(20, 60),
    Attribute.shortBreak: const Tuple2(5, 15),
    Attribute.longBreak: const Tuple2(15, 30),
  };
}