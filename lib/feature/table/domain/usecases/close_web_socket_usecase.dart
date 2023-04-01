import 'package:table_test_project/feature/table/data/repository/interface/table_repository.dart';

class CloseWebSocketChannelUseCase {
  final TableRepository _tableRepository;

  CloseWebSocketChannelUseCase(this._tableRepository);

  Future<void> call() => _tableRepository.closeWebSocketChannel();
}
