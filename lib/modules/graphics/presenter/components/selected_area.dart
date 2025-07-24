import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../lucas_batista_test_exports.dart';

class SelectedArea extends StatelessWidget {
  final SelectionDataCubit selectionDataCubit;
  const SelectedArea({super.key, required this.selectionDataCubit});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectionDataCubit, SelectionDataState>(
      bloc: selectionDataCubit,
      builder: (context, state) {
        if (state is SelectionDrawing) {
          return Positioned.fill(
            child: CustomPaint(painter: DrawingPainter(state.drawingPath)),
          );
        } else if (state is SelectionDone) {
          return Positioned.fromRect(
            rect: state.selectionRect,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.green.withValues(alpha: 0.2),
                border: Border.all(color: Colors.green, width: 2),
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
