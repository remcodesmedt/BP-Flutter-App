import 'package:flutter/material.dart';
import 'package:project_flutter/database/DBHelper.dart';
import 'package:project_flutter/database/tables/IngredientCategoryTable.dart';
import 'package:project_flutter/domain/IngredientCategory.dart';

class IngredientCategoryInterface {
  static Future<List<IngredientCategory>> getItems() async {
    final db = DBHelper.getDB();
    final res = await db.query(IngredientCategoryTable.TABLE_NAME, columns: [
      IngredientCategoryTable.COLUMN_ID,
      IngredientCategoryTable.COLUMN_NAME
    ]);

    List<IngredientCategory> categories = [];

    res.forEach((Map<String, Object?> map) {
      categories.add(IngredientCategory(
          id: map[IngredientCategoryTable.COLUMN_ID] as int,
          name: map[IngredientCategoryTable.COLUMN_NAME] as String));
    });

    return categories;
  }

  static Future<void> insertItems(
      List<IngredientCategory> ingredientCategories) async {
    final db = await DBHelper.getDB();

    ingredientCategories.forEach((it) async {
      final values = <String, Object>{
        IngredientCategoryTable.COLUMN_NAME: it.name
      };

      await db.insert(IngredientCategoryTable.TABLE_NAME, values);
    });
  }
}
