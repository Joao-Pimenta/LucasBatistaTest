part of 'graphic_cubit.dart';

abstract class GraphicState {}

class GraphicInitial extends GraphicState {}

class GraphicLoaded extends GraphicState {
  final RandomChartData lineChartData;
  final LabelLayoutStrategy labelLayoutStrategy;

  GraphicLoaded({
    required this.lineChartData,
    required this.labelLayoutStrategy,
  });
}

class GraphicSelected extends GraphicState {
  final List<Map<String, dynamic>> selectedPoints;

  GraphicSelected({required this.selectedPoints});
}
