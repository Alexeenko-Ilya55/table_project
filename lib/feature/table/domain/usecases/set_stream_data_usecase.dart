import 'package:table_test_project/feature/table/data/repository/interface/table_repository.dart';
import 'package:table_test_project/feature/table/domain/models/table_data_model.dart';

class SetTableDataUseCase {
  final TableRepository _tableRepository;

  SetTableDataUseCase(this._tableRepository);

  Future<void> call(String tableData) =>
      _tableRepository.setTableData(tableData);
}
