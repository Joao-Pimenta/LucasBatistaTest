import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../lucas_batista_test_exports.dart';

class ChartsPage extends StatefulWidget {
  const ChartsPage({super.key});

  @override
  State<ChartsPage> createState() => _ChartsPageState();
}

class _ChartsPageState extends State<ChartsPage> {
  final GetIt getIt = GetIt.instance;
  late ChartsCubit _graphicCubit;
  late SelectionDataCubit _selectionDataCubit;

  @override
  void initState() {
    super.initState();
    _selectionDataCubit = getIt<SelectionDataCubit>();
    _graphicCubit = getIt<ChartsCubit>();
    _graphicCubit.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Charts')),
      body: Column(
        children: [
          BlocBuilder<ChartsCubit, ChartsState>(
            bloc: _graphicCubit,
            builder: (context, state) {
              switch (state) {
                case ChartsInitial():
                  return const SizedBox.shrink();
                case ChartsLoading():
                  return const Center(child: CircularProgressIndicator());
                case ChartsLoaded():
                  return Stack(
                    children: [
                      SelectableChart(
                        spots: state.spots,
                        selectionDataCubit: _selectionDataCubit,
                      ),
                      SelectedArea(selectionDataCubit: _selectionDataCubit),
                    ],
                  );
                case ChartsError():
                  return const Center(child: Text('Erro ao carregar dados'));
                case ChartsEmpty():
                  return const Center(child: Text('Nenhum dado encontrado'));
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
