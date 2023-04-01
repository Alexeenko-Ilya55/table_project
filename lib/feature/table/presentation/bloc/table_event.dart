import 'package:table_test_project/feature/table/domain/models/table_data_model.dart';

abstract class TableEvent {}

class GetTableDataEvent extends TableEvent {}

class SetTableDataEvent extends TableEvent {
  final String data;

  SetTableDataEvent(this.data);
}

class DisposeEvent extends TableEvent {}

class UpdatePageEvent extends TableEvent {
  final TableDataModel updatedData;

  UpdatePageEvent(this.updatedData);
}
