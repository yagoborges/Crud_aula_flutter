
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final _databaseName = "ExemploDB.db";
  static final _databaseVersion = 1;
  static final table = 'contato';
  static final columnId = '_id';
  static final columnNome = 'nome';
  static final columnIdade = 'idade';

  //torna esta classe singleton
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  //Tem somente uma referencia ao banco de dados
  static Database? _database;

  Future<Database> get database async =>
    _database ??= await _initDatabase();

    //abre o banco de dados e o cria se ele não existir
    _initDatabase() async {
      Directory documentsDirectory = await getApplicationDocumentsDirectory();
      String path = join(documentsDirectory.path, _databaseName);
      return await openDatabase(path,
      version: _databaseVersion,
      onCreate: _onCreate);
    }

    //codigo SQL para criar o banco e a tabela
    Future _onCreate(Database db, int version) async {
      await db.execute('''
            CREATE TABLE $table(
              $columnId INTEGER PRIMARY KEY,
              $columnNome TEXT NOT NULL,
              $columnIdade INTEGER NOT NULL
            )
            ''');
    }
}