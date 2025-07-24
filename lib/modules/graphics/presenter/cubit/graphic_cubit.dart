import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'graphic_state.dart';

class GraphicCubit extends Cubit<GraphicState> {
  GraphicCubit() : super(GraphicInitial());

  void init() {
    final allSpots = [
      FlSpot(0, 1),
      FlSpot(1, 3),
      FlSpot(2, 5),
      FlSpot(3, 4),
      FlSpot(4, 7),
    ];
    emit(GraphicLoaded(spots: allSpots));
  }
}
