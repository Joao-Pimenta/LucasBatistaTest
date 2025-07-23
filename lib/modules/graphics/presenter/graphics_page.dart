import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_charts/flutter_charts.dart';
import 'package:get_it/get_it.dart';

import '../../../_exports.dart';

class GraphicsPage extends StatefulWidget {
  const GraphicsPage({super.key});

  @override
  State<GraphicsPage> createState() => _GraphicsPageState();
}

class _GraphicsPageState extends State<GraphicsPage> {
  final GetIt getIt = GetIt.instance;
  late GraphicCubit _graphicCubit;
  late PositionGraphicCubit _positionGraphicCubit;
  bool _isDrawing = false;
  Path _drawnPath = Path();
  final List<Offset> _points = [];

  @override
  void initState() {
    super.initState();
    getIt.registerLazySingleton<PositionGraphicCubit>(
      () => PositionGraphicCubit(),
    );
    _positionGraphicCubit = getIt<PositionGraphicCubit>();
    getIt.registerLazySingleton<GraphicCubit>(
      () => GraphicCubit(_positionGraphicCubit),
    );
    _graphicCubit = getIt<GraphicCubit>();
    _graphicCubit.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Graphics')),
      body: Column(
        children: [
          BlocBuilder<GraphicCubit, GraphicState>(
            bloc: _graphicCubit,
            builder: (context, state) {
              if (state is GraphicLoaded) {
                return Stack(
                  children: [
                    SizedBox(
                      height: 600,
                      width: MediaQuery.of(context).size.width,
                      child: LineChart(
                        painter: LineChartPainter(
                          lineChartContainer: LineChartTopContainer(
                            chartData: state.lineChartData,
                            xContainerLabelLayoutStrategy:
                                state.labelLayoutStrategy,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 600,
                      width: MediaQuery.of(context).size.width,
                      child: GestureDetector(
                        onPanStart: (details) {
                          setState(() {
                            _isDrawing = true;
                            _drawnPath.moveTo(
                              details.localPosition.dx,
                              details.localPosition.dy,
                            );
                            _points.add(details.localPosition);
                          });
                        },
                        onPanUpdate: (details) {
                          setState(() {
                            _drawnPath.lineTo(
                              details.localPosition.dx,
                              details.localPosition.dy,
                            );
                            _points.add(details.localPosition);
                          });
                        },
                        onPanEnd: (details) {
                          setState(() => _isDrawing = false);
                          // Enviar path para o Cubit processar
                          final renderBox =
                              context.findRenderObject() as RenderBox;
                          _graphicCubit.selectPointsInPath(
                            path: _drawnPath,
                            chartSize: renderBox.size,
                          );
                          _drawnPath.reset();
                          _points.clear();
                        },
                        child: CustomPaint(
                          painter: DrawingPainter(_drawnPath),
                          size: Size.infinite,
                        ),
                      ),
                    ),
                    BlocBuilder<PositionGraphicCubit, PositionGraphicState>(
                      bloc: _positionGraphicCubit,
                      builder: (context, state) {
                        if (state is PositionGraphicSelected) {
                          return Positioned(
                            bottom: 10,
                            left: 10,
                            child: Container(
                              padding: EdgeInsets.all(8),
                              color: Colors.white,
                              child: Text(
                                "Selecionados: ${state.selectedPoints.length}",
                              ),
                            ),
                          );
                        }
                        return SizedBox.shrink();
                      },
                    ),
                  ],
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}
