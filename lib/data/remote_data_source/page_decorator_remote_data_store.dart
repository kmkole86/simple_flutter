import 'package:simple_flutter/data/data_source/remote_data_source.dart';
import 'package:simple_flutter/data/model/movie_data.dart';

///In the app, page index starts from 0,
///remote data source (backend) implementation index start from 1,
///so this is a layer that encapsulate behaviour of "decorating"
///the page ordinal, also in this way app logic is not coupled to
///backend logic.
///#decorator pattern
class PageDecoratorRemoteDataStoreImpl implements RemoteDataSource {
  final RemoteDataSource _remoteDataSource;

  const PageDecoratorRemoteDataStoreImpl(
      {required RemoteDataSource remoteDataSource})
      : _remoteDataSource = remoteDataSource;

  @override
  Future<List<PageData>> fetchPages({required List<int> pageOrdinals}) async {
    List<PageData> response = await _remoteDataSource.fetchPages(
        pageOrdinals: pageOrdinals.map((index) => index + 1).toList());

    return response
        .map((page) => PageData(
            ordinal: page.ordinal - 1,
            totalPages: page.totalPages,
            totalResults: page.totalResults,
            movies: page.movies))
        .toList();
  }
}
