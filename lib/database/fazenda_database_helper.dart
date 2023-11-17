import 'dart:io';
import 'package:agrobrain/models/Fazendas.dart';
import 'package:agrobrain/models/Piquete.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DataBaseFazendaHelper{
  static final _databaseName = "database.db";
  static final _databaseVersion = 1;

  static final columnId = 'id';
  static final columnName = 'nome';
  static final columnArea = 'area';
  static final columnProprietario = 'proprietario';
  static final columnLatitude = 'latitude';
  static final columnLongitude = 'longitude';

  DataBaseFazendaHelper._privateConstructor();

  static final DataBaseFazendaHelper instance = DataBaseFazendaHelper._privateConstructor();

  static Database? _database ;

  Future<Database> get database async {
    if (_database != null) return _database!;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE fazenda (
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
            $columnName TEXT NOT NULL,
            $columnArea DOUBLE NOT NULL,
            $columnProprietario TEXT NOT NULL,
            $columnLatitude DOUBLE NOT NULL,
            $columnLongitude DOUBLE NOT NULL
            );
          ''');
    await db.execute('''
          CREATE TABLE piquete(
                $columnId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
                $columnName TEXT NOT NULL,
                $columnArea DOUBLE NOT NULL,
                massaEstimada DOUBLE NOT NULL,
                idFazenda INTEGER NOT NULL
              );
          ''');
  }

  //Fazenda
  // =======================================================================================================================
  Future<int> insertFazenda(Fazenda fazenda) async {
    final db = await instance.database;
    var res = await db.insert("fazenda", fazenda.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return res;
  }

  Future<List<Fazenda>> getAllFazendas() async {
    Database db = await instance.database;
    var res = await db.query("fazenda");
    List<Fazenda> list =
    res.isNotEmpty ? res.map((c) => Fazenda.fromMap(c)).toList() : [];
    return list;
  }

  Future<Fazenda> getFazendaById(int idFazenda) async {
    final db = await database;
    var res = await db.rawQuery(
        'SELECT * FROM fazenda WHERE $columnId = $idFazenda LIMIT 1');
    Fazenda fazenda =  res.isNotEmpty ? res.map((c) => Fazenda.fromMap(c)).toList()[0]:[] as Fazenda;
    return fazenda;
  }

  Future<int?> queryRowCountFazenda() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM fazenda'));
  }

  Future<int> updateFazenda(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[columnId];
    return await db.update("fazenda", row, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> deleteFazenda(int id) async {
    Database db = await instance.database;
    return await db.delete("fazenda", where: '$columnId = ?', whereArgs: [id]);
  }
  // =======================================================================================================================

  //Piquete
  // =======================================================================================================================
  Future<int> insertPiquete(Piquete piquete) async {
    final db = await instance.database;
    var res = await db.insert("piquete", piquete.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return res;
  }

  Future<List<Piquete>> getAllPiquete() async {
    Database db = await instance.database;
    var res = await db.query("piquete");
    List<Piquete> list =
    res.isNotEmpty ? res.map((c) => Piquete.fromMap(c)).toList() : [];
    return list;
  }

  Future<Piquete> getPiqueteById(int idPiquete) async {
    final db = await database;
    var res = await db.rawQuery(
        'SELECT * FROM piquete WHERE $columnId = $idPiquete LIMIT 1');
    Piquete piquete =  res.isNotEmpty ? res.map((c) => Piquete.fromMap(c)).toList()[0]:[] as Piquete;
    return piquete;
  }

  Future<List<Piquete>> getAllPiquetesByIdFazenda(int idfazenda) async {
    final db = await database;
    var res = await db.rawQuery(
        'SELECT * FROM piquete WHERE idFazenda = $idfazenda ');
    List<Piquete> piquetes =  res.isNotEmpty ? res.map((c) => Piquete.fromMap(c)).toList():[];
    return piquetes;
  }

  Future<int?> queryRowCountPiquete() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM piquete'));
  }

  Future<int> updatePiquete(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[columnId];
    return await db.update("piquete", row, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> deletePiquete(int id) async {
    Database db = await instance.database;
    return await db.delete("piquete", where: '$columnId = ?', whereArgs: [id]);
  }
  // =======================================================================================================================

}