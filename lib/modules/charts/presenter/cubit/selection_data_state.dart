part of 'selection_data_cubit.dart';

abstract class SelectionDataState {
  const SelectionDataState();
}

class SelectionIdle extends SelectionDataState {}

class SelectionDrawing extends SelectionDataState {
  final Path drawingPath;

  const SelectionDrawing(this.drawingPath);
}

class SelectionDone extends SelectionDataState {
  final Rect selectionRect;
  final List<FlSpot> selectedSpots;

  const SelectionDone(this.selectionRect, this.selectedSpots);
}
