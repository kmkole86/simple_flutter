import 'package:simple_flutter/data/model/movie_data.dart';

abstract class RemoteDataSource {
  Future<List<PageData>> fetchPages({required List<int> pageOrdinals});
}
