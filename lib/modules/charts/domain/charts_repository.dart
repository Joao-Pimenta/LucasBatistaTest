import 'package:dartz/dartz.dart';

import '../../../lucas_batista_test_exports.dart';

abstract class ChartsRepository {
  Future<Either<Exception, List<ChartEntity>>> getData();
}

class ChartsRepositoryImpl implements ChartsRepository {
  final ChartsDataSource dataSource;

  ChartsRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Exception, List<ChartEntity>>> getData() async {
    try {
      final result = await dataSource.getData();
      return Right(result);
    } catch (e) {
      return Left(Exception(e));
    }
  }
}
