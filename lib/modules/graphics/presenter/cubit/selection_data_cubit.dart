import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'selection_data_state.dart';

class SelectionDataCubit extends Cubit<SelectionDataState> {
  Path _path = Path();

  SelectionDataCubit() : super(SelectionIdle());

  void startSelection(Offset start) {
    _path = Path()..moveTo(start.dx, start.dy);
    emit(SelectionDrawing(_path));
  }

  void updateSelection(Offset next) {
    _path.lineTo(next.dx, next.dy);
    emit(SelectionDrawing(Path.from(_path)));
  }

  Rect _calculateBoundingRectFromPath(Path path) {
    final pathMetrics = path.computeMetrics(forceClosed: false);
    double minX = double.infinity;
    double minY = double.infinity;
    double maxX = double.negativeInfinity;
    double maxY = double.negativeInfinity;

    for (final metric in pathMetrics) {
      for (double i = 0; i < metric.length; i += 1.0) {
        final pos = metric.getTangentForOffset(i)?.position;
        if (pos != null) {
          minX = pos.dx < minX ? pos.dx : minX;
          maxX = pos.dx > maxX ? pos.dx : maxX;
          minY = pos.dy < minY ? pos.dy : minY;
          maxY = pos.dy > maxY ? pos.dy : maxY;
        }
      }
    }

    if (minX == double.infinity || minY == double.infinity) {
      return Rect.zero;
    }

    return Rect.fromLTRB(minX, minY, maxX, maxY);
  }

  double _getMaxX(List<FlSpot> spots) =>
      spots.map((e) => e.x).fold(0.0, (a, b) => a > b ? a : b);

  double _getMaxY(List<FlSpot> spots) =>
      spots.map((e) => e.y).fold(0.0, (a, b) => a > b ? a : b);

  void endSelection(
    List<FlSpot> allSpots,
    Size chartSize,
    double chartWidth,
    double chartHeight,
  ) {
    if (state is! SelectionDrawing) return;

    final drawingPath = (state as SelectionDrawing).drawingPath;
    final rect = _calculateBoundingRectFromPath(drawingPath);

    final selectedSpots = allSpots.where((spot) {
      final x = spot.x / _getMaxX(allSpots) * chartWidth;
      final y = chartHeight - (spot.y / _getMaxY(allSpots) * chartHeight);
      return rect.contains(Offset(x, y));
    }).toList();

    emit(SelectionDone(rect, selectedSpots));
  }
}
