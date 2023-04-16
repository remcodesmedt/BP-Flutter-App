import 'package:flutter/material.dart';
import 'package:project_flutter/database/DBHelper.dart';
import 'package:project_flutter/database/tables/IngredientCategoryTable.dart';
import 'package:project_flutter/domain/IngredientCategory.dart';

class IngredientCategoryInterface {
  static Future<List<IngredientCategory>> getItems() async {
    final db = DBHelper.getDB();

    var columns = IngredientCategoryTable.COLUMNS_FOR_SELECT;

    final res =
        await db.query(IngredientCategoryTable.TABLE_NAME, columns: columns);

    List<IngredientCategory> categories = [];

    res.forEach((Map<String, Object?> map) {
      categories.add(IngredientCategory(
          id: map[IngredientCategoryTable.COLUMN_ID] as int,
          name: map[IngredientCategoryTable.COLUMN_NAME] as String));
    });

    return categories;
  }

  static Future<void> insertItem(IngredientCategory ingredientCategory) async {
    final db = DBHelper.getDB();

    final values = <String, Object>{
      IngredientCategoryTable.COLUMN_NAME: ingredientCategory.name
    };

    await db.insert(IngredientCategoryTable.TABLE_NAME, values);
  }
}
