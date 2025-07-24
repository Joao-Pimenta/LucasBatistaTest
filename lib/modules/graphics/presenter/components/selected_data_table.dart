import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../lucas_batista_test_exports.dart';

class SelectedDataTable extends StatelessWidget {
  final SelectionDataCubit selectionDataCubit;
  const SelectedDataTable({super.key, required this.selectionDataCubit});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectionDataCubit, SelectionDataState>(
      bloc: selectionDataCubit,
      builder: (context, state) {
        if (state is SelectionDone) {
          if (state.selectedSpots.isEmpty) {
            return const Text("Nenhum dado selecionado");
          }
          return DataTable(
            columns: const [
              DataColumn(label: Text("X")),
              DataColumn(label: Text("Y")),
            ],
            rows: state.selectedSpots.map((spot) {
              return DataRow(
                cells: [
                  DataCell(Text(spot.x.toStringAsFixed(2))),
                  DataCell(Text(spot.y.toStringAsFixed(2))),
                ],
              );
            }).toList(),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
