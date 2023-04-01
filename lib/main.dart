import 'package:flutter/material.dart';
import 'package:table_test_project/core/di/injection_container.dart' as di;
import 'package:table_test_project/table_app.dart';

void main() {
  initMain();
}

initMain() async {
  await di.init();
  runApp(const TableApp());
}