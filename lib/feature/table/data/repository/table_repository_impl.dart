import 'package:table_test_project/feature/table/data/datasource/interface/web_socket_datasource.dart';
import 'package:table_test_project/feature/table/data/repository/interface/table_repository.dart';
import 'package:table_test_project/feature/table/domain/models/table_data_model.dart';

class TableRepositoryImpl extends TableRepository {
  final WebSocketDatasource _webSocketDatasource;

  TableRepositoryImpl(this._webSocketDatasource);

  @override
  Future<Stream<TableDataModel>> getStreamData() =>
      _webSocketDatasource.getStreamData();

  @override
  Future<void> setTableData(String dataModel) async =>
      _webSocketDatasource.setTableData(dataModel);

  @override
  Future<void> closeWebSocketChannel() async =>
      _webSocketDatasource.closeWebSocketChannel();
}
