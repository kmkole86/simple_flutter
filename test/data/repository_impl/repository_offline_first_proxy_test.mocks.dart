// Mocks generated by Mockito 5.4.2 from annotations
// in simple_flutter/test/data/repository_impl/repository_offline_first_proxy_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:either_dart/either.dart' as _i5;
import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i8;
import 'package:simple_flutter/core/model/range.dart' as _i2;
import 'package:simple_flutter/data/data_source/local_data_source.dart' as _i9;
import 'package:simple_flutter/data/model/movie_data.dart' as _i10;
import 'package:simple_flutter/domain/entity/movie_entity.dart' as _i7;
import 'package:simple_flutter/domain/repository/movie_repository.dart' as _i3;
import 'package:simple_flutter/domain/use_case/get_movies_page_range_use_case.dart'
    as _i6;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeRange_0 extends _i1.SmartFake implements _i2.Range {
  _FakeRange_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [MovieRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockMovieRepository extends _i1.Mock implements _i3.MovieRepository {
  @override
  _i4.Future<_i5.Either<_i6.GetPageError, List<_i7.Page>>> getMoviePageRange(
          {required _i2.Range? range}) =>
      (super.noSuchMethod(
        Invocation.method(
          #getMoviePageRange,
          [],
          {#range: range},
        ),
        returnValue:
            _i4.Future<_i5.Either<_i6.GetPageError, List<_i7.Page>>>.value(
                _i8.dummyValue<_i5.Either<_i6.GetPageError, List<_i7.Page>>>(
          this,
          Invocation.method(
            #getMoviePageRange,
            [],
            {#range: range},
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i5.Either<_i6.GetPageError, List<_i7.Page>>>.value(
                _i8.dummyValue<_i5.Either<_i6.GetPageError, List<_i7.Page>>>(
          this,
          Invocation.method(
            #getMoviePageRange,
            [],
            {#range: range},
          ),
        )),
      ) as _i4.Future<_i5.Either<_i6.GetPageError, List<_i7.Page>>>);
}

/// A class which mocks [LocalDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockLocalDataSource extends _i1.Mock implements _i9.LocalDataSource {
  @override
  _i4.Future<void> insertPages({required List<_i10.PageData>? pages}) =>
      (super.noSuchMethod(
        Invocation.method(
          #insertPages,
          [],
          {#pages: pages},
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
  @override
  _i4.Future<_i2.Range> getCachedRangeWithinLimits(
          {required _i2.Range? range}) =>
      (super.noSuchMethod(
        Invocation.method(
          #getCachedRangeWithinLimits,
          [],
          {#range: range},
        ),
        returnValue: _i4.Future<_i2.Range>.value(_FakeRange_0(
          this,
          Invocation.method(
            #getCachedRangeWithinLimits,
            [],
            {#range: range},
          ),
        )),
        returnValueForMissingStub: _i4.Future<_i2.Range>.value(_FakeRange_0(
          this,
          Invocation.method(
            #getCachedRangeWithinLimits,
            [],
            {#range: range},
          ),
        )),
      ) as _i4.Future<_i2.Range>);
  @override
  _i4.Future<bool> isRangeCached({required _i2.Range? range}) =>
      (super.noSuchMethod(
        Invocation.method(
          #isRangeCached,
          [],
          {#range: range},
        ),
        returnValue: _i4.Future<bool>.value(false),
        returnValueForMissingStub: _i4.Future<bool>.value(false),
      ) as _i4.Future<bool>);
  @override
  _i4.Future<List<_i10.PageData>> getCachedPages({required _i2.Range? range}) =>
      (super.noSuchMethod(
        Invocation.method(
          #getCachedPages,
          [],
          {#range: range},
        ),
        returnValue: _i4.Future<List<_i10.PageData>>.value(<_i10.PageData>[]),
        returnValueForMissingStub:
            _i4.Future<List<_i10.PageData>>.value(<_i10.PageData>[]),
      ) as _i4.Future<List<_i10.PageData>>);
  @override
  _i4.Future<void> deletePage({required int? pageOrdinal}) =>
      (super.noSuchMethod(
        Invocation.method(
          #deletePage,
          [],
          {#pageOrdinal: pageOrdinal},
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
}