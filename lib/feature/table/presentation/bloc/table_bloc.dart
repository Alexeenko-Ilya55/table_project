import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_test_project/core/constants/initial_table_data.dart';
import 'package:table_test_project/core/di/injection_container.dart';
import 'package:table_test_project/feature/table/domain/usecases/close_web_socket_usecase.dart';
import 'package:table_test_project/feature/table/domain/usecases/get_stream_data_usecase.dart';
import 'package:table_test_project/feature/table/domain/usecases/set_stream_data_usecase.dart';
import 'package:table_test_project/feature/table/presentation/bloc/table_event.dart';
import 'package:table_test_project/feature/table/presentation/bloc/table_state.dart';

class TableBloc extends Bloc<TableEvent, TableState> {
  final GetStreamDataUseCase _getStreamDataUseCase = getIt();
  final SetTableDataUseCase _setTableDataUseCase = getIt();
  final CloseWebSocketChannelUseCase _closeWebSocketChannelUseCase = getIt();

  TableBloc() : super(TableState(columns: initialColumns, rows: initialRows)) {
    on<GetTableDataEvent>(_onGetTableData);
    on<UpdatePageEvent>(_onUpdatePage);
    on<SetTableDataEvent>(_onSetTableData);
    on<DisposeEvent>(_onDisposeEvent);
  }

  Future<void> _onGetTableData(_, Emitter emit) async {
    final dataStream = await _getStreamDataUseCase();
    dataStream.listen((snapshot) {
      add(UpdatePageEvent(snapshot));
    });
  }

  Future<void> _onUpdatePage(UpdatePageEvent event, Emitter emit) async =>
      emit(state.copyWith(rows: event.updatedData.data));

  FutureOr<void> _onDisposeEvent(_, __) => _closeWebSocketChannelUseCase();

  FutureOr<void> _onSetTableData(SetTableDataEvent event, _) =>
      _setTableDataUseCase(event.data);
}
