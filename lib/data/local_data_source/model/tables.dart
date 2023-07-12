import 'package:drift/drift.dart';

@DataClassName('MovieDbModel')
class MoviesTbl extends Table {
  IntColumn get id => integer()();

  RealColumn get voteAverage => real()();

  IntColumn get voteCount => integer()();

  IntColumn get pageOrdinal => integer()();///.references(PageTbl, #ordinal)();

  TextColumn get title => text()();

  TextColumn get overview => text()();

  TextColumn get posterPath => text()();

  TextColumn get releaseDate => text()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('PageDbModel')
class PageTbl extends Table {
  IntColumn get ordinal => integer()();

  IntColumn get totalPages => integer()();

  IntColumn get totalResults => integer()();

  @override
  Set<Column> get primaryKey => {ordinal};
}
