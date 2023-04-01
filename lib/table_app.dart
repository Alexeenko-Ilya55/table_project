import 'package:flutter/material.dart';
import 'package:table_test_project/feature/table/presentation/page/table_page.dart';

class TableApp extends StatelessWidget {
  const TableApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TablePage(),
    );
  }
}
