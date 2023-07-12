import 'package:simple_flutter/core/model/range.dart';
import 'package:simple_flutter/core/utils/range_utils.dart';
import 'package:test/test.dart';

void main() {
  const RangeUtils rangeUtils = RangeUtils();

  test("should cover case when ranges overlap", () {
    Range range1 = const Range(fromInclusive: 0, toExclusive: 3);
    Range range2 = const Range(fromInclusive: 0, toExclusive: 5);

    Range resultRange = const Range(fromInclusive: 3, toExclusive: 5);

    expect(rangeUtils.rangeDifference(range1: range1, range2: range2),
        resultRange);
  });

  test("should cover case when one range is contained into another", () {
    Range range1 = const Range(fromInclusive: 2, toExclusive: 3);
    Range range2 = const Range(fromInclusive: 0, toExclusive: 5);

    Range resultRange = const Range(fromInclusive: 3, toExclusive: 5);

    expect(rangeUtils.rangeDifference(range1: range1, range2: range2),
        resultRange);
  });

  test("param order should not affect result", () {
    Range range1 = const Range(fromInclusive: 2, toExclusive: 3);
    Range range2 = const Range(fromInclusive: 0, toExclusive: 5);

    Range resultRange = const Range(fromInclusive: 3, toExclusive: 5);

    expect(rangeUtils.rangeDifference(range1: range2, range2: range1),
        resultRange);
  });
}
