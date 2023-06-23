import 'package:brasileirao/models/time.dart';
import 'package:brasileirao/repository/times_repository.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DB {
  DB._();

  static final DB instance = DB._();
  static Database? _database;

  static Future<Database> get() async {
    return await DB.instance.database;
  }

  Future<Database> get database async {
    return _database ??= await initDatabase();
  }

  initDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'dados.db'),
      version: 1,
      onCreate: (db, version) async {
        await db.execute(times);
        await db.execute(titulos);
        await setupTimes(db);
      }
    );
  }

  String get times => '''
    CREATE TABLE times (
      id INTEGER PRIMARY KEY AUTOINCREMENT, 
      nome TEXT,
      pontos INTEGER,
      brasao TEXT,
      cor TEXT,
      idAPI INTEGER
    );
  ''';

  String get titulos => '''
    CREATE TABLE titulos (
      id INTEGER PRIMARY KEY AUTOINCREMENT, 
      campeonato TEXT,
      ano TEXT,
      time_id INTEGER,
      FOREIGN KEY (time_id) REFERENCES times(id) ON DELETE CASCADE
    );
  ''';

  setupTimes(db) async {
    for (Time time in TimesRepository.setupTimes()) {
      // print('TimesRepository: ${time.nome}');
      await db.insert('times', {
        'nome': time.nome,
        'brasao': time.brasao,
        'pontos': time.pontos,
        // 'idAPI': time.idAPI,
        'cor': time.cor.toString().replaceAll('Color(', '').replaceAll(')', ''),
      });
    }
  }
}
