import 'package:flutter/material.dart';

class AppTable extends StatelessWidget {
  final List<String> columns; 
  final List<List<Widget>> rows; 

  const AppTable({super.key, required this.columns, required this.rows});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: columns
            .map((title) => DataColumn(label: Text(title)))
            .toList(),
        rows: rows
            .map(
              (row) =>
                  DataRow(cells: row.map((cell) => DataCell(cell)).toList()),
            )
            .toList(),
            decoration: BoxDecoration(border: BoxBorder.all(),borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
