import 'package:simple_flutter/data/mappers/response_mapper.dart';
import 'package:simple_flutter/data/model/movie_data.dart';
import 'package:simple_flutter/data/remote_data_source/rest_client.dart';

import '../data_source/remote_data_source.dart';

class RemoteDataSourceImpl implements RemoteDataSource {
  const RemoteDataSourceImpl(
      {required RestClient restClient, required ResponseMapper responseMapper})
      : _restClient = restClient,
        _responseMapper = responseMapper;

  final RestClient _restClient;
  final ResponseMapper _responseMapper;

  @override
  Future<List<PageData>> fetchPages({required List<int> pageOrdinals}) async {
    return await Stream.fromIterable(pageOrdinals)
        .asyncMap((page) => _restClient.fetchPage(page: page))
        .map((event) => _responseMapper.mapToPage(event))
        .toList();
  }
}
