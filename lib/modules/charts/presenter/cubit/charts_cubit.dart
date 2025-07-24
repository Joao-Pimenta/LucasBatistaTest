import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../lucas_batista_test_exports.dart';

part 'charts_state.dart';

class ChartsCubit extends Cubit<ChartsState> {
  final ChartsRepository repository;

  ChartsCubit({required this.repository}) : super(ChartsInitial());

  void init() async {
    emit(ChartsLoading());
    final result = await repository.getData();
    result.fold((error) => emit(ChartsError(error: error)), (data) {
      if (data.isEmpty) {
        emit(ChartsEmpty());
      } else {
        emit(ChartsLoaded(spots: data.map((e) => FlSpot(e.x, e.y)).toList()));
      }
    });
  }
}
