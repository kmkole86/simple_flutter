import '../model/range.dart';

class RangeUtils {
  const RangeUtils();

  ///for the sake of simplicity
  ///just cover ideal case, when ranges overlap
  ///not implemented to cover all the cases
  Range rangeDifference({required Range range1, required Range range2}) {
    if (range1.toExclusive < range2.toExclusive) {
      return Range(
          fromInclusive: range1.toExclusive, toExclusive: range2.toExclusive);
    } else {
      return Range(
          fromInclusive: range2.toExclusive, toExclusive: range1.toExclusive);
    }
  }

  List<int> pageOrdinals({required Range range}) {
    return List.generate(range.toExclusive - range.fromInclusive,
        (index) => range.fromInclusive + index);
  }
}
