// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'simple_database.dart';

// ignore_for_file: type=lint
class $MoviesTblTable extends MoviesTbl
    with TableInfo<$MoviesTblTable, MovieDbModel> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;

  $MoviesTblTable(this.attachedDatabase, [this._alias]);

  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _voteAverageMeta =
      const VerificationMeta('voteAverage');
  @override
  late final GeneratedColumn<double> voteAverage = GeneratedColumn<double>(
      'vote_average', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _voteCountMeta =
      const VerificationMeta('voteCount');
  @override
  late final GeneratedColumn<int> voteCount = GeneratedColumn<int>(
      'vote_count', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _pageOrdinalMeta =
      const VerificationMeta('pageOrdinal');
  @override
  late final GeneratedColumn<int> pageOrdinal = GeneratedColumn<int>(
      'page_ordinal', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _overviewMeta =
      const VerificationMeta('overview');
  @override
  late final GeneratedColumn<String> overview = GeneratedColumn<String>(
      'overview', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _posterPathMeta =
      const VerificationMeta('posterPath');
  @override
  late final GeneratedColumn<String> posterPath = GeneratedColumn<String>(
      'poster_path', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _releaseDateMeta =
      const VerificationMeta('releaseDate');
  @override
  late final GeneratedColumn<String> releaseDate = GeneratedColumn<String>(
      'release_date', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);

  @override
  List<GeneratedColumn> get $columns => [
        id,
        voteAverage,
        voteCount,
        pageOrdinal,
        title,
        overview,
        posterPath,
        releaseDate
      ];

  @override
  String get aliasedName => _alias ?? 'movies_tbl';

  @override
  String get actualTableName => 'movies_tbl';

  @override
  VerificationContext validateIntegrity(Insertable<MovieDbModel> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('vote_average')) {
      context.handle(
          _voteAverageMeta,
          voteAverage.isAcceptableOrUnknown(
              data['vote_average']!, _voteAverageMeta));
    } else if (isInserting) {
      context.missing(_voteAverageMeta);
    }
    if (data.containsKey('vote_count')) {
      context.handle(_voteCountMeta,
          voteCount.isAcceptableOrUnknown(data['vote_count']!, _voteCountMeta));
    } else if (isInserting) {
      context.missing(_voteCountMeta);
    }
    if (data.containsKey('page_ordinal')) {
      context.handle(
          _pageOrdinalMeta,
          pageOrdinal.isAcceptableOrUnknown(
              data['page_ordinal']!, _pageOrdinalMeta));
    } else if (isInserting) {
      context.missing(_pageOrdinalMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('overview')) {
      context.handle(_overviewMeta,
          overview.isAcceptableOrUnknown(data['overview']!, _overviewMeta));
    } else if (isInserting) {
      context.missing(_overviewMeta);
    }
    if (data.containsKey('poster_path')) {
      context.handle(
          _posterPathMeta,
          posterPath.isAcceptableOrUnknown(
              data['poster_path']!, _posterPathMeta));
    } else if (isInserting) {
      context.missing(_posterPathMeta);
    }
    if (data.containsKey('release_date')) {
      context.handle(
          _releaseDateMeta,
          releaseDate.isAcceptableOrUnknown(
              data['release_date']!, _releaseDateMeta));
    } else if (isInserting) {
      context.missing(_releaseDateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};

  @override
  MovieDbModel map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MovieDbModel(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      voteAverage: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}vote_average'])!,
      voteCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}vote_count'])!,
      pageOrdinal: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}page_ordinal'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      overview: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}overview'])!,
      posterPath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}poster_path'])!,
      releaseDate: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}release_date'])!,
    );
  }

  @override
  $MoviesTblTable createAlias(String alias) {
    return $MoviesTblTable(attachedDatabase, alias);
  }
}

class MovieDbModel extends DataClass implements Insertable<MovieDbModel> {
  final int id;
  final double voteAverage;
  final int voteCount;
  final int pageOrdinal;

  ///.references(PageTbl, #ordinal)();
  final String title;
  final String overview;
  final String posterPath;
  final String releaseDate;

  const MovieDbModel(
      {required this.id,
      required this.voteAverage,
      required this.voteCount,
      required this.pageOrdinal,
      required this.title,
      required this.overview,
      required this.posterPath,
      required this.releaseDate});

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['vote_average'] = Variable<double>(voteAverage);
    map['vote_count'] = Variable<int>(voteCount);
    map['page_ordinal'] = Variable<int>(pageOrdinal);
    map['title'] = Variable<String>(title);
    map['overview'] = Variable<String>(overview);
    map['poster_path'] = Variable<String>(posterPath);
    map['release_date'] = Variable<String>(releaseDate);
    return map;
  }

  MoviesTblCompanion toCompanion(bool nullToAbsent) {
    return MoviesTblCompanion(
      id: Value(id),
      voteAverage: Value(voteAverage),
      voteCount: Value(voteCount),
      pageOrdinal: Value(pageOrdinal),
      title: Value(title),
      overview: Value(overview),
      posterPath: Value(posterPath),
      releaseDate: Value(releaseDate),
    );
  }

  factory MovieDbModel.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MovieDbModel(
      id: serializer.fromJson<int>(json['id']),
      voteAverage: serializer.fromJson<double>(json['voteAverage']),
      voteCount: serializer.fromJson<int>(json['voteCount']),
      pageOrdinal: serializer.fromJson<int>(json['pageOrdinal']),
      title: serializer.fromJson<String>(json['title']),
      overview: serializer.fromJson<String>(json['overview']),
      posterPath: serializer.fromJson<String>(json['posterPath']),
      releaseDate: serializer.fromJson<String>(json['releaseDate']),
    );
  }

  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'voteAverage': serializer.toJson<double>(voteAverage),
      'voteCount': serializer.toJson<int>(voteCount),
      'pageOrdinal': serializer.toJson<int>(pageOrdinal),
      'title': serializer.toJson<String>(title),
      'overview': serializer.toJson<String>(overview),
      'posterPath': serializer.toJson<String>(posterPath),
      'releaseDate': serializer.toJson<String>(releaseDate),
    };
  }

  MovieDbModel copyWith(
          {int? id,
          double? voteAverage,
          int? voteCount,
          int? pageOrdinal,
          String? title,
          String? overview,
          String? posterPath,
          String? releaseDate}) =>
      MovieDbModel(
        id: id ?? this.id,
        voteAverage: voteAverage ?? this.voteAverage,
        voteCount: voteCount ?? this.voteCount,
        pageOrdinal: pageOrdinal ?? this.pageOrdinal,
        title: title ?? this.title,
        overview: overview ?? this.overview,
        posterPath: posterPath ?? this.posterPath,
        releaseDate: releaseDate ?? this.releaseDate,
      );

  @override
  String toString() {
    return (StringBuffer('MovieDbModel(')
          ..write('id: $id, ')
          ..write('voteAverage: $voteAverage, ')
          ..write('voteCount: $voteCount, ')
          ..write('pageOrdinal: $pageOrdinal, ')
          ..write('title: $title, ')
          ..write('overview: $overview, ')
          ..write('posterPath: $posterPath, ')
          ..write('releaseDate: $releaseDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, voteAverage, voteCount, pageOrdinal,
      title, overview, posterPath, releaseDate);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MovieDbModel &&
          other.id == this.id &&
          other.voteAverage == this.voteAverage &&
          other.voteCount == this.voteCount &&
          other.pageOrdinal == this.pageOrdinal &&
          other.title == this.title &&
          other.overview == this.overview &&
          other.posterPath == this.posterPath &&
          other.releaseDate == this.releaseDate);
}

class MoviesTblCompanion extends UpdateCompanion<MovieDbModel> {
  final Value<int> id;
  final Value<double> voteAverage;
  final Value<int> voteCount;
  final Value<int> pageOrdinal;
  final Value<String> title;
  final Value<String> overview;
  final Value<String> posterPath;
  final Value<String> releaseDate;

  const MoviesTblCompanion({
    this.id = const Value.absent(),
    this.voteAverage = const Value.absent(),
    this.voteCount = const Value.absent(),
    this.pageOrdinal = const Value.absent(),
    this.title = const Value.absent(),
    this.overview = const Value.absent(),
    this.posterPath = const Value.absent(),
    this.releaseDate = const Value.absent(),
  });

  MoviesTblCompanion.insert({
    this.id = const Value.absent(),
    required double voteAverage,
    required int voteCount,
    required int pageOrdinal,
    required String title,
    required String overview,
    required String posterPath,
    required String releaseDate,
  })  : voteAverage = Value(voteAverage),
        voteCount = Value(voteCount),
        pageOrdinal = Value(pageOrdinal),
        title = Value(title),
        overview = Value(overview),
        posterPath = Value(posterPath),
        releaseDate = Value(releaseDate);

  static Insertable<MovieDbModel> custom({
    Expression<int>? id,
    Expression<double>? voteAverage,
    Expression<int>? voteCount,
    Expression<int>? pageOrdinal,
    Expression<String>? title,
    Expression<String>? overview,
    Expression<String>? posterPath,
    Expression<String>? releaseDate,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (voteAverage != null) 'vote_average': voteAverage,
      if (voteCount != null) 'vote_count': voteCount,
      if (pageOrdinal != null) 'page_ordinal': pageOrdinal,
      if (title != null) 'title': title,
      if (overview != null) 'overview': overview,
      if (posterPath != null) 'poster_path': posterPath,
      if (releaseDate != null) 'release_date': releaseDate,
    });
  }

  MoviesTblCompanion copyWith(
      {Value<int>? id,
      Value<double>? voteAverage,
      Value<int>? voteCount,
      Value<int>? pageOrdinal,
      Value<String>? title,
      Value<String>? overview,
      Value<String>? posterPath,
      Value<String>? releaseDate}) {
    return MoviesTblCompanion(
      id: id ?? this.id,
      voteAverage: voteAverage ?? this.voteAverage,
      voteCount: voteCount ?? this.voteCount,
      pageOrdinal: pageOrdinal ?? this.pageOrdinal,
      title: title ?? this.title,
      overview: overview ?? this.overview,
      posterPath: posterPath ?? this.posterPath,
      releaseDate: releaseDate ?? this.releaseDate,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (voteAverage.present) {
      map['vote_average'] = Variable<double>(voteAverage.value);
    }
    if (voteCount.present) {
      map['vote_count'] = Variable<int>(voteCount.value);
    }
    if (pageOrdinal.present) {
      map['page_ordinal'] = Variable<int>(pageOrdinal.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (overview.present) {
      map['overview'] = Variable<String>(overview.value);
    }
    if (posterPath.present) {
      map['poster_path'] = Variable<String>(posterPath.value);
    }
    if (releaseDate.present) {
      map['release_date'] = Variable<String>(releaseDate.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MoviesTblCompanion(')
          ..write('id: $id, ')
          ..write('voteAverage: $voteAverage, ')
          ..write('voteCount: $voteCount, ')
          ..write('pageOrdinal: $pageOrdinal, ')
          ..write('title: $title, ')
          ..write('overview: $overview, ')
          ..write('posterPath: $posterPath, ')
          ..write('releaseDate: $releaseDate')
          ..write(')'))
        .toString();
  }
}

class $PageTblTable extends PageTbl with TableInfo<$PageTblTable, PageDbModel> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;

  $PageTblTable(this.attachedDatabase, [this._alias]);

  static const VerificationMeta _ordinalMeta =
      const VerificationMeta('ordinal');
  @override
  late final GeneratedColumn<int> ordinal = GeneratedColumn<int>(
      'ordinal', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _totalPagesMeta =
      const VerificationMeta('totalPages');
  @override
  late final GeneratedColumn<int> totalPages = GeneratedColumn<int>(
      'total_pages', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _totalResultsMeta =
      const VerificationMeta('totalResults');
  @override
  late final GeneratedColumn<int> totalResults = GeneratedColumn<int>(
      'total_results', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);

  @override
  List<GeneratedColumn> get $columns => [ordinal, totalPages, totalResults];

  @override
  String get aliasedName => _alias ?? 'page_tbl';

  @override
  String get actualTableName => 'page_tbl';

  @override
  VerificationContext validateIntegrity(Insertable<PageDbModel> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('ordinal')) {
      context.handle(_ordinalMeta,
          ordinal.isAcceptableOrUnknown(data['ordinal']!, _ordinalMeta));
    }
    if (data.containsKey('total_pages')) {
      context.handle(
          _totalPagesMeta,
          totalPages.isAcceptableOrUnknown(
              data['total_pages']!, _totalPagesMeta));
    } else if (isInserting) {
      context.missing(_totalPagesMeta);
    }
    if (data.containsKey('total_results')) {
      context.handle(
          _totalResultsMeta,
          totalResults.isAcceptableOrUnknown(
              data['total_results']!, _totalResultsMeta));
    } else if (isInserting) {
      context.missing(_totalResultsMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {ordinal};

  @override
  PageDbModel map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PageDbModel(
      ordinal: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}ordinal'])!,
      totalPages: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}total_pages'])!,
      totalResults: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}total_results'])!,
    );
  }

  @override
  $PageTblTable createAlias(String alias) {
    return $PageTblTable(attachedDatabase, alias);
  }
}

class PageDbModel extends DataClass implements Insertable<PageDbModel> {
  final int ordinal;
  final int totalPages;
  final int totalResults;

  const PageDbModel(
      {required this.ordinal,
      required this.totalPages,
      required this.totalResults});

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['ordinal'] = Variable<int>(ordinal);
    map['total_pages'] = Variable<int>(totalPages);
    map['total_results'] = Variable<int>(totalResults);
    return map;
  }

  PageTblCompanion toCompanion(bool nullToAbsent) {
    return PageTblCompanion(
      ordinal: Value(ordinal),
      totalPages: Value(totalPages),
      totalResults: Value(totalResults),
    );
  }

  factory PageDbModel.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PageDbModel(
      ordinal: serializer.fromJson<int>(json['ordinal']),
      totalPages: serializer.fromJson<int>(json['totalPages']),
      totalResults: serializer.fromJson<int>(json['totalResults']),
    );
  }

  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'ordinal': serializer.toJson<int>(ordinal),
      'totalPages': serializer.toJson<int>(totalPages),
      'totalResults': serializer.toJson<int>(totalResults),
    };
  }

  PageDbModel copyWith({int? ordinal, int? totalPages, int? totalResults}) =>
      PageDbModel(
        ordinal: ordinal ?? this.ordinal,
        totalPages: totalPages ?? this.totalPages,
        totalResults: totalResults ?? this.totalResults,
      );

  @override
  String toString() {
    return (StringBuffer('PageDbModel(')
          ..write('ordinal: $ordinal, ')
          ..write('totalPages: $totalPages, ')
          ..write('totalResults: $totalResults')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(ordinal, totalPages, totalResults);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PageDbModel &&
          other.ordinal == this.ordinal &&
          other.totalPages == this.totalPages &&
          other.totalResults == this.totalResults);
}

class PageTblCompanion extends UpdateCompanion<PageDbModel> {
  final Value<int> ordinal;
  final Value<int> totalPages;
  final Value<int> totalResults;

  const PageTblCompanion({
    this.ordinal = const Value.absent(),
    this.totalPages = const Value.absent(),
    this.totalResults = const Value.absent(),
  });

  PageTblCompanion.insert({
    this.ordinal = const Value.absent(),
    required int totalPages,
    required int totalResults,
  })  : totalPages = Value(totalPages),
        totalResults = Value(totalResults);

  static Insertable<PageDbModel> custom({
    Expression<int>? ordinal,
    Expression<int>? totalPages,
    Expression<int>? totalResults,
  }) {
    return RawValuesInsertable({
      if (ordinal != null) 'ordinal': ordinal,
      if (totalPages != null) 'total_pages': totalPages,
      if (totalResults != null) 'total_results': totalResults,
    });
  }

  PageTblCompanion copyWith(
      {Value<int>? ordinal, Value<int>? totalPages, Value<int>? totalResults}) {
    return PageTblCompanion(
      ordinal: ordinal ?? this.ordinal,
      totalPages: totalPages ?? this.totalPages,
      totalResults: totalResults ?? this.totalResults,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (ordinal.present) {
      map['ordinal'] = Variable<int>(ordinal.value);
    }
    if (totalPages.present) {
      map['total_pages'] = Variable<int>(totalPages.value);
    }
    if (totalResults.present) {
      map['total_results'] = Variable<int>(totalResults.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PageTblCompanion(')
          ..write('ordinal: $ordinal, ')
          ..write('totalPages: $totalPages, ')
          ..write('totalResults: $totalResults')
          ..write(')'))
        .toString();
  }
}

abstract class _$SimpleDbImpl extends GeneratedDatabase {
  _$SimpleDbImpl(QueryExecutor e) : super(e);
  late final $MoviesTblTable moviesTbl = $MoviesTblTable(this);
  late final $PageTblTable pageTbl = $PageTblTable(this);

  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();

  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [moviesTbl, pageTbl];
}
