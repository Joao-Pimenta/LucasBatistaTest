part of 'charts_cubit.dart';

abstract class ChartsState {}

class ChartsInitial extends ChartsState {}

class ChartsLoading extends ChartsState {}

class ChartsLoaded extends ChartsState {
  final List<FlSpot> spots;

  ChartsLoaded({required this.spots});
}

class ChartsError extends ChartsState {
  final Exception error;

  ChartsError({required this.error});
}

class ChartsEmpty extends ChartsState {}
