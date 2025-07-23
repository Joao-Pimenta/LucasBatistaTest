part of 'position_graphic_cubit.dart';

abstract class PositionGraphicState {}

class PositionGraphicInitial extends PositionGraphicState {}

class PositionGraphicSelected extends PositionGraphicState {
  final List<Map<String, dynamic>> selectedPoints;

  PositionGraphicSelected({required this.selectedPoints});
}
