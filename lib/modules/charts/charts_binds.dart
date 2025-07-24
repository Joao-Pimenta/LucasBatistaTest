import 'package:get_it/get_it.dart';

import '../../lucas_batista_test_exports.dart';

class ChartsBinds {
  static void call(GetIt getIt) {
    getIt.registerLazySingleton<ChartsDataSource>(() => ChartsDataSourceImpl());
    getIt.registerLazySingleton<ChartsRepository>(
      () => ChartsRepositoryImpl(dataSource: getIt<ChartsDataSource>()),
    );
    getIt.registerLazySingleton<SelectionDataCubit>(() => SelectionDataCubit());
    getIt.registerLazySingleton<ChartsCubit>(
      () => ChartsCubit(repository: getIt<ChartsRepository>()),
    );
  }
}
