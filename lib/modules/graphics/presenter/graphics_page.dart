import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../lucas_batista_test_exports.dart';

class GraphicsPage extends StatefulWidget {
  const GraphicsPage({super.key});

  @override
  State<GraphicsPage> createState() => _GraphicsPageState();
}

class _GraphicsPageState extends State<GraphicsPage> {
  final GetIt getIt = GetIt.instance;
  late GraphicCubit _graphicCubit;
  late SelectionDataCubit _selectionDataCubit;

  @override
  void initState() {
    super.initState();
    getIt.registerLazySingleton<SelectionDataCubit>(() => SelectionDataCubit());
    _selectionDataCubit = getIt<SelectionDataCubit>();
    getIt.registerLazySingleton<GraphicCubit>(() => GraphicCubit());
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
                    SelectableChart(
                      spots: state.spots,
                      selectionDataCubit: _selectionDataCubit,
                    ),
                    SelectedArea(selectionDataCubit: _selectionDataCubit),
                  ],
                );
              }
              return const SizedBox.shrink();
            },
          ),
          SelectedDataTable(selectionDataCubit: _selectionDataCubit),
        ],
      ),
    );
  }
}
