part of 'graphic_cubit.dart';

abstract class GraphicState {}

class GraphicInitial extends GraphicState {}

class GraphicLoaded extends GraphicState {
  final List<FlSpot> spots;

  GraphicLoaded({required this.spots});
}

class GraphicSelected extends GraphicState {
  final List<Map<String, dynamic>> selectedPoints;

  GraphicSelected({required this.selectedPoints});
}
