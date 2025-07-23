import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_charts/flutter_charts.dart';

import '../../../_exports.dart';
part 'graphic_state.dart';

class GraphicCubit extends Cubit<GraphicState> {
  final PositionGraphicCubit _positionGraphicCubit;
  GraphicCubit(this._positionGraphicCubit) : super(GraphicInitial());

  void init() {
    ChartOptions chartOptions = const ChartOptions();
    final chartData = RandomChartData.generated(chartOptions: chartOptions);
    final xContainerLabelLayoutStrategy = DefaultIterativeLabelLayoutStrategy(
      options: chartOptions,
    );
    emit(
      GraphicLoaded(
        lineChartData: chartData,
        labelLayoutStrategy: xContainerLabelLayoutStrategy,
      ),
    );
  }

  void selectPointsInPath({required Path path, required Size chartSize}) {
    if (state is! GraphicLoaded) return;
    final current = state as GraphicLoaded;
    final selected = <Map<String, dynamic>>[];

    final data = current.lineChartData;

    // Obtemos os valores do gráfico
    final rowCount = data.dataRows.length;
    final colCount = data.dataRows[0].length;

    for (int i = 0; i < rowCount; i++) {
      for (int j = 0; j < colCount; j++) {
        final value = data.dataRows[i][j];

        // Transformar j em X pixel e value em Y pixel
        final double x = j / (colCount - 1) * chartSize.width;
        final double y =
            chartSize.height -
            (value /
                10.0 *
                chartSize.height); // Assumindo que o valor máximo é 10.0

        final offset = Offset(x, y);
        if (path.contains(offset)) {
          selected.add({'row': i, 'column': j, 'value': value, 'x': x, 'y': y});
        }
      }
    }
    _positionGraphicCubit.selectPoints(selectedPoints: selected);
  }
}
