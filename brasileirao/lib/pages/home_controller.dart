import 'package:brasileirao/models/time.dart';
import 'package:brasileirao/repository/times_repository.dart';

class HomeController {
  late TimesRepository repository;

  List<Time> get tabela => repository.times;

  HomeController() {
    repository = TimesRepository();
  }
}
