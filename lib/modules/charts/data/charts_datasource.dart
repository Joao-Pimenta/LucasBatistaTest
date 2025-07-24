import '../../../lucas_batista_test_exports.dart';

abstract class ChartsDataSource {
  Future<List<ChartEntity>> getData();
}

class ChartsDataSourceImpl implements ChartsDataSource {
  @override
  Future<List<ChartEntity>> getData() {
    return Future.delayed(const Duration(milliseconds: 200), () {
      return [
        ChartEntity(x: 0, y: 1),
        ChartEntity(x: 1, y: 3),
        ChartEntity(x: 2, y: 5),
        ChartEntity(x: 3, y: 4),
        ChartEntity(x: 4, y: 7),
      ];
    });
  }
}
