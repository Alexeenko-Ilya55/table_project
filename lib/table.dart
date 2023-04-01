
//Реализация этой же программы в одном файле

import 'dart:convert';

import 'package:editable/editable.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

void main() {
  runApp(const TableApplication());
}

const _appBarTitle = 'Table app';
const _webSocketUrl = 'wss://ws.postman-echo.com/raw';
const _rowId = 'row';
const _saveIconSize = 24.0;
const _columnRatio = 0.25;

class TableApplication extends StatelessWidget {
  const TableApplication({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _webSocketUri = Uri.parse(_webSocketUrl);
  late final WebSocketChannel _channel;
  List<Map<dynamic, dynamic>> rows = List.from(_initialRows);

  @override
  void initState() {
    super.initState();
    _channel = WebSocketChannel.connect(_webSocketUri);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(_appBarTitle),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: _channel.stream,
        builder: (context, snapshot) {
          return Editable(
            columns: _columns,
            rows: snapshot.hasData ? jsonDecode(snapshot.data) : rows,
            showCreateButton: true,
            showSaveIcon: true,
            columnRatio: _columnRatio,
            borderColor: Colors.grey,
            saveIconSize: _saveIconSize,
            saveIcon: Icons.save,
            saveIconColor: Colors.blue,
            onRowSaved: (value) {
              if (value.runtimeType != String) {
                final row = value as Map<dynamic, dynamic>;
                if (rows
                    .where((element) => element[_rowId] == row[_rowId])
                    .isNotEmpty) {
                  final index = rows
                      .indexWhere((element) => element[_rowId] == row[_rowId]);
                  rows[index] = row;
                } else {
                  rows.add(row);
                }
                _channel.sink.add(jsonEncode(rows));
              }
            },
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _channel.sink.close();
    super.dispose();
  }
}

const _columns = [
  {"title": '', 'index': 1, 'key': '1'},
  {"title": '', 'index': 2, 'key': '2'},
  {"title": '', 'index': 3, 'key': '3'},
];
const _initialRows = [
  {"row": 0, "1": '', "2": '', "3": ''},
  {"row": 1, "1": '', "2": '', "3": ''},
  {"row": 2, "1": '', "2": '', "3": ''}
];