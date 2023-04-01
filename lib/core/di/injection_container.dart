import 'package:get_it/get_it.dart';
import 'package:table_test_project/feature/table/data/datasource/interface/web_socket_datasource.dart';
import 'package:table_test_project/feature/table/data/datasource/web_socket_datasource_impl.dart';
import 'package:table_test_project/feature/table/data/repository/table_repository_impl.dart';
import 'package:table_test_project/feature/table/data/repository/interface/table_repository.dart';
import 'package:table_test_project/feature/table/domain/usecases/close_web_socket_usecase.dart';
import 'package:table_test_project/feature/table/domain/usecases/get_stream_data_usecase.dart';
import 'package:table_test_project/feature/table/domain/usecases/set_stream_data_usecase.dart';
import 'package:table_test_project/feature/table/presentation/bloc/table_bloc.dart';

final getIt = GetIt.instance;

Future<void> init() async {

  //UseCases
  getIt.registerLazySingleton(() => SetTableDataUseCase(getIt()));
  getIt.registerLazySingleton(() => GetStreamDataUseCase(getIt()));
  getIt.registerLazySingleton(() => CloseWebSocketChannelUseCase(getIt()));

  //repository
  getIt.registerLazySingleton<TableRepository>(() => TableRepositoryImpl(getIt()));

  //datasource
  getIt.registerLazySingleton<WebSocketDatasource>(() => WebSocketDatasourceImpl());

  //BloC
  getIt.registerFactory(() => TableBloc());
}