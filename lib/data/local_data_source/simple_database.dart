import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:simple_flutter/core/model/range.dart';
import 'package:simple_flutter/data/local_data_source/db_model_mapper.dart';
import 'package:simple_flutter/data/model/movie_data.dart';

import 'model/tables.dart';

part 'simple_database.g.dart';

@DriftDatabase(tables: [MoviesTbl, PageTbl])
class SimpleDbImpl extends _$SimpleDbImpl implements SimpleDb {
  SimpleDbImpl({required DbModelMapper dbModelMapper})
      : _dbModelMapper = dbModelMapper,
        super(_openConnection());

  final DbModelMapper _dbModelMapper;

  @override
  int get schemaVersion => 1;

  @override
  Future<void> deletePage({required int pageOrdinal}) async {
    await transaction(() async {
      (delete(pageTbl).where((tbl) => tbl.ordinal.equals(pageOrdinal)));
      (delete(moviesTbl).where((tbl) => tbl.pageOrdinal.equals(pageOrdinal)));
    });
  }

  @override
  Future<List<PageData>> getCachedPages({required Range range}) async {
    return transaction(() async {
      List<PageData> result = [];
      final List<PageDbModel> pages = await (select(pageTbl)
            ..where((tbl) =>
                tbl.ordinal.isBiggerOrEqualValue(range.fromInclusive) &
                tbl.ordinal.isSmallerThanValue(range.toExclusive))
            ..orderBy([
              (u) => OrderingTerm(expression: u.ordinal, mode: OrderingMode.asc)
            ]))
          .get();

      for (final page in pages) {
        final List<MovieDbModel> movies = await (select(moviesTbl)
              ..where((tbl) => tbl.pageOrdinal.equals(page.ordinal)))
            .get();
        result.add(PageData(
            ordinal: page.ordinal,
            totalPages: page.totalPages,
            totalResults: page.totalPages,
            movies: _dbModelMapper.mapToMoviesData(
                pageOrdinal: page.ordinal, data: movies)));
      }
      return result;
    });
  }

  @override
  Future<bool> isRangeCached({required Range range}) async {
    return range == (await getCachedRangeWithinLimits(range: range));
  }

  @override
  Future<Range> getCachedRangeWithinLimits({required Range range}) async {
    final List<PageDbModel> pages = await (select(pageTbl)
          ..where((tbl) =>
              tbl.ordinal.isBiggerOrEqualValue(range.fromInclusive) &
              tbl.ordinal.isSmallerThanValue(range.toExclusive))
          ..orderBy([
            (u) => OrderingTerm(expression: u.ordinal, mode: OrderingMode.asc)
          ]))
        .get();
    if (pages.isEmpty) {
      return const Range(fromInclusive: 0, toExclusive: 0);
    } else {
      return Range(
          fromInclusive: pages.first.ordinal,
          toExclusive: pages.last.ordinal + 1);
    }
  }

  @override
  Future<void> insertPages({required List<PageData> pages}) async {
    final List<PageDbModel> pagesDb =
        pages.map((p) => _dbModelMapper.mapToPageDb(p)).toList();

    final List<MovieDbModel> moviesDb = pages
        .expand((element) => _dbModelMapper.mapToMoviesDb(
            pageOrdinal: element.ordinal, data: element.movies))
        .toList();

    await batch((batch) async {
      batch.insertAll(pageTbl, pagesDb, mode: InsertMode.insertOrReplace);
      batch.insertAll(moviesTbl, moviesDb, mode: InsertMode.insertOrReplace);
    });
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}

abstract class SimpleDb {
  Future<void> insertPages({required List<PageData> pages});

  Future<Range> getCachedRangeWithinLimits({required Range range});

  Future<bool> isRangeCached({required Range range});

  Future<List<PageData>> getCachedPages({required Range range});

  Future<void> deletePage({required int pageOrdinal});
}
