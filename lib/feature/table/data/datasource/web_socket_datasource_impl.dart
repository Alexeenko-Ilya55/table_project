import 'dart:convert';

import 'package:table_test_project/feature/table/data/datasource/interface/web_socket_datasource.dart';
import 'package:table_test_project/feature/table/domain/models/table_data_model.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

const _webSocketUrl = 'wss://ws.postman-echo.com/raw';

class WebSocketDatasourceImpl extends WebSocketDatasource {
  final Uri _webSocketUri = Uri.parse(_webSocketUrl);
  late WebSocketChannel _webSocketChannel;

  WebSocketDatasourceImpl() {
    _webSocketChannel = WebSocketChannel.connect(_webSocketUri);
  }

  @override
  Future<Stream<TableDataModel>> getStreamData() async {
    return _webSocketChannel.stream.map(
      (event) => TableDataModel((jsonDecode(event as String) as List<dynamic>)
          .cast<Map<dynamic, dynamic>>()),
    );
  }

  @override
  Future<void> setTableData(String dataModel) async =>
      _webSocketChannel.sink.add(dataModel);

  @override
  Future<void> closeWebSocketChannel() async => _webSocketChannel.sink.close();
}
