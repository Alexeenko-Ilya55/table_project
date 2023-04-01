class TableState {
  final List columns;
  final List<Map<dynamic,dynamic>> rows;

  TableState({required this.columns, required this.rows});

  TableState copyWith({List? columns, List<Map<dynamic,dynamic>>? rows}) {
    return TableState(
      rows: rows ?? this.rows,
      columns: columns ?? this.columns,
    );
  }
}
