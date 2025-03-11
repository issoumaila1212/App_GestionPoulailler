import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "poulailler.db");

    return await openDatabase(
      path,
      version: 2, // 🚀 Change ici si tu fais une migration
      onCreate: _onCreate,
      onUpgrade: _onUpgrade, // Ajout pour gérer les mises à jour de la base
    );
  }

  // 📌 Création des tables
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE cycles (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        type TEXT NOT NULL,
        start_date TEXT NOT NULL,
        end_date TEXT,
        initial_count INTEGER NOT NULL,
        status TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE depenses (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        cycle_id INTEGER,
        type TEXT NOT NULL,
        amount REAL NOT NULL,
        synced INTEGER DEFAULT 0,
        FOREIGN KEY (cycle_id) REFERENCES cycles (id) ON DELETE CASCADE
      )
    ''');

    await db.execute('''
      CREATE TABLE ventes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        cycle_id INTEGER,
        type TEXT NOT NULL,
        quantity INTEGER NOT NULL,
        price REAL NOT NULL,
        synced INTEGER DEFAULT 0,
        FOREIGN KEY (cycle_id) REFERENCES cycles (id) ON DELETE CASCADE
      )
    ''');

    await db.execute('''
      CREATE TABLE pertes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        cycle_id INTEGER,
        cause TEXT NOT NULL,
        count INTEGER NOT NULL,
        synced INTEGER DEFAULT 0,
        FOREIGN KEY (cycle_id) REFERENCES cycles (id) ON DELETE CASCADE
      )
    ''');
  }

  // 📌 Gestion des mises à jour de la base (si tu veux ajouter une nouvelle colonne)
  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < newVersion) {
      await db.execute('DROP TABLE IF EXISTS cycles');
      await db.execute('DROP TABLE IF EXISTS depenses');
      await db.execute('DROP TABLE IF EXISTS ventes');
      await db.execute('DROP TABLE IF EXISTS pertes');
      _onCreate(db, newVersion);
    }
  }
}
