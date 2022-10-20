import 'package:portal_berita/model/berita.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();
  static Database? _database;

  final String tableName = 'tableJudul';
  final String columnId = 'id';
  final String columnJudul = 'judul';
  final String columnPengarang = 'pengarang';
  final String columnTanggal = 'tanggal';
  final String columnIsi = 'isi';

  DBHelper._internal();
  factory DBHelper() => _instance;

  Future<Database?> get _db async {
    if (_database != null) {
      return _database;
    }
    _database = await _initDb();
    return _database;
  }

  Future<Database?> _initDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'berita_db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    var sql = "CREATE TABLE $tableName($columnId INTEGER PRIMARY KEY,"
        "$columnJudul TEXT,"
        "$columnPengarang TEXT,"
        "$columnTanggal TEXT,"
        "$columnIsi TEXT)";
    await db.execute(sql);
  }

  Future<int?> saveBerita(Berita berita) async {
    var dbClient = await _db;
    return await dbClient!.insert(tableName, berita.toMap());
  }

  Future<List?> getAllBerita() async {
    var dbClient = await _db;
    var result = await dbClient!
        .query(tableName, columns: [columnId, columnJudul, columnPengarang, columnTanggal, columnIsi]);
    return result.toList();
  }

  Future<int?> updateBerita (Berita berita) async {
    var dbClient = await _db;
    return await dbClient!.update(tableName, berita.toMap(),
        where: '$columnId = ?', whereArgs: [berita.id]);
  }

  Future<int?> deleteBerita (int id) async {
    var dbClient = await _db;
    return await dbClient!
        .delete(tableName, where: '$columnId = ?', whereArgs: [id]);
  }
}