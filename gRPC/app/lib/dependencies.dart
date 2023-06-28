import 'package:app/my_home_page_cubit.dart';
import 'package:app/my_home_page_repository.dart';
import 'package:get_it/get_it.dart';

final serviceLocator = GetIt.instance;

class Dependencies {
  static void setUp() {
    serviceLocator.registerLazySingleton(() => MyHomePageRepository());
    serviceLocator.registerLazySingleton(() => MyHomePageCubit(
        repository: serviceLocator.get<MyHomePageRepository>()));
  }
}
