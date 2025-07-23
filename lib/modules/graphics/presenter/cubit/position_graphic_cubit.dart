import 'package:flutter_bloc/flutter_bloc.dart';
part 'position_graphic_state.dart';

class PositionGraphicCubit extends Cubit<PositionGraphicState> {
  PositionGraphicCubit() : super(PositionGraphicInitial());

  void selectPoints({required List<Map<String, dynamic>> selectedPoints}) {
    emit(PositionGraphicSelected(selectedPoints: selectedPoints));
  }
}
