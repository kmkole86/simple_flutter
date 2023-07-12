import 'package:simple_flutter/core/model/range.dart';
import 'package:simple_flutter/data/model/movie_data.dart';

abstract class LocalDataSource {
  Future<void> insertPages({required List<PageData> pages});

  Future<Range> getCachedRangeWithinLimits({required Range range});

  Future<bool> isRangeCached({required Range range});

  Future<List<PageData>> getCachedPages({required Range range});

  Future<void> deletePage({required int pageOrdinal});
}
