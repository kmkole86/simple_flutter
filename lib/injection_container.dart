import 'package:get_it/get_it.dart';
import 'package:simple_flutter/core/utils/range_utils.dart';
import 'package:simple_flutter/data/data_source/local_data_source.dart';
import 'package:simple_flutter/data/data_source/remote_data_source.dart';
import 'package:simple_flutter/data/local_data_source/db_model_mapper.dart';
import 'package:simple_flutter/data/local_data_source/local_data_source_impl.dart';
import 'package:simple_flutter/data/local_data_source/simple_database.dart';
import 'package:simple_flutter/data/mappers/data_mapper.dart';
import 'package:simple_flutter/data/mappers/entity_mapper.dart';
import 'package:simple_flutter/data/mappers/response_mapper.dart';
import 'package:simple_flutter/data/remote_data_source/common/dio_factory.dart';
import 'package:simple_flutter/data/remote_data_source/page_decorator_remote_data_store.dart';
import 'package:simple_flutter/data/remote_data_source/remote_data_source_impl.dart';
import 'package:simple_flutter/data/repository_impl/movie_repository_impl.dart';
import 'package:simple_flutter/domain/repository/movie_repository.dart';
import 'package:simple_flutter/domain/use_case/get_movies_page_range_use_case.dart';
import 'package:simple_flutter/features/feed/bloc/feed_bloc.dart';

import 'data/remote_data_source/rest_client.dart';
import 'data/repository_impl/repository_cache_decorator.dart';
import 'data/repository_impl/repository_offline_first_proxy.dart';
import 'data/repository_impl/repository_page_range_decorator.dart';

final di = GetIt.instance;

const String remoteDSKey = "remoteDS";
const String pageDecoratorRemoteDSKey = "pageDecoratorRemoteDS";

const String movieRepository = "movieRepository";
const String cacheDecoratorRepository = "cacheDecoratorRepository";
const String pageRangeDecoratorRepository = "pageRangeDecoratorRepository";
const String offlineProxyRepository = "offlineProxyRepository";

void init() {
  //mapper
  di.registerFactory<DbModelMapper>(() => const DbModelMapper());
  di.registerFactory<ResponseMapper>(() => const ResponseMapper());
  di.registerFactory<EntityMapper>(() => const EntityMapper());
  di.registerFactory<DataMapper>(() => const DataMapper());

  //utils
  di.registerFactory<RangeUtils>(() => const RangeUtils());

  //db, rest
  di.registerLazySingleton<SimpleDb>(() => SimpleDbImpl(dbModelMapper: di()));
  di.registerLazySingleton(() => const DioFactory().createClient());
  di.registerLazySingleton(() => RestClient(di()));

  //data_source
  di.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImpl(restClient: di(), responseMapper: di()),
      instanceName: remoteDSKey);
  di.registerLazySingleton<RemoteDataSource>(
      () => PageDecoratorRemoteDataStoreImpl(
          remoteDataSource: di.get(instanceName: remoteDSKey)),
      instanceName: pageDecoratorRemoteDSKey);

  di.registerLazySingleton<LocalDataSource>(
      () => LocalDataSourceImpl(db: di()));

  //repo
  di.registerLazySingleton<MovieRepository>(
      () => MovieRepositoryImpl(
          remoteDataSource: di.get(instanceName: pageDecoratorRemoteDSKey),
          entityMapper: di(),
          rangeUtils: di()),
      instanceName: movieRepository);

  di.registerLazySingleton<MovieRepository>(
      () => RepositoryCacheDecorator(
          repository: di.get(instanceName: movieRepository),
          localDataSource: di(),
          dataMapper: di(),
          entityMapper: di()),
      instanceName: cacheDecoratorRepository);

  di.registerLazySingleton<MovieRepository>(
      () => RepositoryPageRangeDecorator(
          repository: di.get(instanceName: cacheDecoratorRepository),
          localDataSource: di(),
          rangeUtils: di()),
      instanceName: pageRangeDecoratorRepository);

  di.registerLazySingleton<MovieRepository>(
      () => RepositoryOfflineFirstProxy(
          repository: di.get(instanceName: pageRangeDecoratorRepository),
          localDataSource: di(),
          entityMapper: di()),
      instanceName: offlineProxyRepository);

  //use_case
  di.registerFactory(() => GetPageRangeUseCase(
      repository: di.get(instanceName: offlineProxyRepository)));

  //bloc
  di.registerLazySingleton(
      () => FeedBloc(getPageRangeUseCase: di(), mapper: FeedUiItemsMapper()));
}
