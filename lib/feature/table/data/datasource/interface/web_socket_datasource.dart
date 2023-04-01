import 'package:table_test_project/feature/table/domain/models/table_data_model.dart';

abstract class WebSocketDatasource {
  Future<Stream<TableDataModel>> getStreamData();

  Future<void> setTableData(String dataModel);

  Future<void> closeWebSocketChannel();
}
