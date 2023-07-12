import 'package:simple_flutter/core/model/range.dart';
import 'package:simple_flutter/data/local_data_source/simple_database.dart';
import 'package:simple_flutter/data/model/movie_data.dart';

import '../data_source/local_data_source.dart';

class LocalDataSourceImpl implements LocalDataSource {
  const LocalDataSourceImpl({required SimpleDb db}) : _db = db;

  final SimpleDb _db;

  @override
  Future<void> deletePage({required int pageOrdinal}) {
    return _db.deletePage(pageOrdinal: pageOrdinal);
  }

  @override
  Future<Range> getCachedRangeWithinLimits({required Range range}) {
    return _db.getCachedRangeWithinLimits(range: range);
  }

  @override
  Future<void> insertPages({required List<PageData> pages}) {
    return _db.insertPages(pages: pages);
  }

  @override
  Future<List<PageData>> getCachedPages({required Range range}) {
    return _db.getCachedPages(range: range);
  }

  @override
  Future<bool> isRangeCached({required Range range}) {
    return _db.isRangeCached(range: range);
  }
}
