import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../../lucas_batista_test_exports.dart';

class SelectableChart extends StatelessWidget {
  final List<FlSpot> spots;
  final SelectionDataCubit selectionDataCubit;
  const SelectableChart({
    super.key,
    required this.spots,
    required this.selectionDataCubit,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 0.8,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final chartSize = Size(constraints.maxWidth, constraints.maxHeight);
          return LineChart(
            LineChartData(
              lineBarsData: [
                LineChartBarData(
                  spots: spots,
                  isCurved: false,
                  barWidth: 2,
                  color: Colors.amber,
                  dotData: FlDotData(show: true),
                ),
              ],
              gridData: FlGridData(
                show: true,
                drawVerticalLine: true,
                getDrawingHorizontalLine: (value) {
                  return FlLine(color: const Color(0xff37434d), strokeWidth: 1);
                },
                getDrawingVerticalLine: (value) {
                  return FlLine(color: const Color(0xff37434d), strokeWidth: 1);
                },
              ),
              borderData: FlBorderData(show: true),
              titlesData: FlTitlesData(show: true),
              lineTouchData: LineTouchData(
                enabled: true,
                touchCallback:
                    (FlTouchEvent event, LineTouchResponse? response) {
                      if (event is FlPanStartEvent) {
                        selectionDataCubit.startSelection(event.localPosition);
                      } else if (event is FlPanUpdateEvent) {
                        selectionDataCubit.updateSelection(event.localPosition);
                      } else if (event is FlPanEndEvent) {
                        selectionDataCubit.endSelection(
                          spots,
                          chartSize,
                          chartSize.width,
                          chartSize.height,
                        );
                      }
                    },
              ),
            ),
          );
        },
      ),
    );
  }
}
