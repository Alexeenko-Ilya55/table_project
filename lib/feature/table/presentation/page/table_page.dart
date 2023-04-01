import 'dart:convert';

import 'package:editable/editable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_test_project/core/di/injection_container.dart';
import 'package:table_test_project/feature/table/presentation/bloc/table_bloc.dart';
import 'package:table_test_project/feature/table/presentation/bloc/table_event.dart';
import 'package:table_test_project/feature/table/presentation/bloc/table_state.dart';

const _appBarTitle = 'Table app';
const _saveIconSize = 24.0;
const _columnRatio = 0.25;
const _rowId = 'row';
const _fontSize = 17.0;

class TablePage extends StatelessWidget {
  const TablePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          _appBarTitle,
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: _fontSize),
        ),
        centerTitle: true,
      ),
      body: BlocProvider<TableBloc>(
        create: (context) {
          final TableBloc bloc = getIt();
          bloc.add(GetTableDataEvent());
          return bloc;
        },
        child: BlocBuilder<TableBloc, TableState>(
          builder: (context, state) {
            return Editable(
              columns: state.columns,
              rows: state.rows,
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
                  final List<Map<dynamic, dynamic>> rows =
                      List.from(state.rows);
                  if (rows
                      .where((element) => element[_rowId] == row[_rowId])
                      .isNotEmpty) {
                    final index = rows.indexWhere(
                        (element) => element[_rowId] == row[_rowId]);
                    rows[index] = row;
                  } else {
                    rows.add(row);
                  }
                  context.read<TableBloc>().add(
                        SetTableDataEvent(jsonEncode(rows)),
                      );
                }
              },
            );
          },
        ),
      ),
    );
  }
}
