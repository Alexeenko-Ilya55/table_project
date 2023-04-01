import 'package:table_test_project/feature/table/data/repository/interface/table_repository.dart';
import 'package:table_test_project/feature/table/domain/models/table_data_model.dart';

class GetStreamDataUseCase{
  final TableRepository _tableRepository;
  GetStreamDataUseCase(this._tableRepository);

  Future<Stream<TableDataModel>> call() => _tableRepository.getStreamData();
}