import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'tables/IngredientCategoryTable.dart';
import 'tables/IngredientTable.dart';

class DBHelper {
  static late Database _db;

  static Future<void> _createTables(Database db, int version) async {
    print("creating tables");
    await db.execute(IngredientCategoryTable.CREATE_TABLE);
    await db.execute(IngredientTable.CREATE_TABLE);
  }

  static Future<void> _upgradeTables(
      Database db, int oldVersion, int newVersion) async {
    await _dropAll(db);
    await _createTables(db, newVersion);
  }

  static Future<void> _dropAll(Database db) async {
    print("dropping tables");
    await db.execute(IngredientCategoryTable.DROP_TABLE);
    await db.execute(IngredientTable.DROP_TABLE);
  }

  static Future<void> init() async {
    print("initializing db");
    _db = await openDatabase(
      join(await getDatabasesPath(), 'example.db'),
      onCreate: (db, version) async {
        await _dropAll(db);
        return await _createTables(db, version);
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        return await _upgradeTables(db, oldVersion, newVersion);
      },
      //TODO uncomment, just for now to always drop
      onOpen: (db) async {
        await _upgradeTables(db, 1 ,1);
      },
      version: 1,
    );
  }

  static Database getDB() {
    return _db;
  }
}
