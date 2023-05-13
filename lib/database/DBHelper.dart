import 'package:path/path.dart';
import 'package:project_flutter/database/tables/DishTable.dart';
import 'package:project_flutter/database/tables/ExtraImageTable.dart';
import 'package:project_flutter/database/tables/IngredientAmountTable.dart';
import 'package:project_flutter/database/tables/MealPlanDishTable.dart';
import 'package:project_flutter/database/tables/MealPlanTable.dart';
import 'package:project_flutter/database/tables/ShoppingListTable.dart';
import 'package:sqflite/sqflite.dart';

import 'tables/IngredientCategoryTable.dart';
import 'tables/IngredientTable.dart';

class DBHelper {
  static late Database _db;

  static Future<void> _createTables(Database db, int version) async {
    print("creating tables");
    await db.execute(IngredientCategoryTable.CREATE_TABLE);
    await db.execute(IngredientTable.CREATE_TABLE);
    await db.execute(ShoppingListTable.CREATE_TABLE);
    await db.execute(DishTable.CREATE_TABLE);
    await db.execute(IngredientAmountTable.CREATE_TABLE);
    await db.execute(MealPlanTable.CREATE_TABLE);
    await db.execute(MealPlanDishTable.CREATE_TABLE);
    await db.execute(ExtraImageTable.CREATE_TABLE);
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
    await db.execute(ShoppingListTable.DROP_TABLE);
    await db.execute(DishTable.DROP_TABLE);
    await db.execute(IngredientAmountTable.DROP_TABLE);
    await db.execute(MealPlanTable.DROP_TABLE);
    await db.execute(MealPlanDishTable.DROP_TABLE);
    await db.execute(ExtraImageTable.DROP_TABLE);
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
