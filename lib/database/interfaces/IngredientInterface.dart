import 'package:flutter/material.dart';
import 'package:project_flutter/database/DBHelper.dart';
import 'package:project_flutter/database/tables/IngredientCategoryTable.dart';
import 'package:project_flutter/domain/EUnit.dart';
import 'package:project_flutter/domain/IngredientCategory.dart';

import '../../domain/Ingredient.dart';
import '../tables/IngredientTable.dart';

class IngredientInterface {
  static Future<List<Ingredient>> getItems() async {
    final db = DBHelper.getDB();

    var columns = [
      IngredientTable.COLUMN_ID,
      "${IngredientTable.TABLE_NAME}.${IngredientTable.COLUMN_NAME}",
      IngredientTable.COLUMN_UNIT,
      "${IngredientCategoryTable.TABLE_NAME}.${IngredientCategoryTable.COLUMN_NAME} AS category_name",
      "${IngredientTable.TABLE_NAME}.${IngredientTable.COLUMN_INGREDIENTCATEGORY}"
    ];

    var joinClause = "${IngredientTable.TABLE_NAME} INNER JOIN "
        "${IngredientCategoryTable.TABLE_NAME} "
        "ON ${IngredientTable.TABLE_NAME}.${IngredientTable.COLUMN_INGREDIENTCATEGORY} "
        "= ${IngredientCategoryTable.TABLE_NAME}.${IngredientCategoryTable.COLUMN_ID}";

    final res =
        await db.rawQuery("SELECT ${columns.join(',')} FROM $joinClause");

    List<Ingredient> ingredients = [];

    res.forEach((Map<String, Object?> map) {
      var id = map[IngredientTable.COLUMN_ID] as int;
      var name = map[IngredientTable.COLUMN_NAME] as String;
      var unitString = map[IngredientTable.COLUMN_UNIT] as String;
      var categoryid = map[IngredientTable.COLUMN_INGREDIENTCATEGORY] as int;
      var categoryname = map["category_name"] as String;

      var unit = EUnit.g;
      switch (unitString) {
        case "g":
          unit = EUnit.g;
          break;
        case "ml":
          unit = EUnit.ml;
          break;
      }

      ingredients.add(Ingredient(
        id: id,
        name: name,
        unit: unit,
        category: IngredientCategory(id: categoryid, name: categoryname),
      ));
    });

    return ingredients;
  }

  static Future<void> insertItems(Ingredient ingredient) async {
    final db = DBHelper.getDB();

      final values = <String, Object>{
        IngredientTable.COLUMN_NAME: ingredient.name,
        IngredientTable.COLUMN_UNIT: ingredient.unit.toString(),
        IngredientTable.COLUMN_INGREDIENTCATEGORY: ingredient.category.id
      };

      await db.insert(IngredientTable.TABLE_NAME, values);
  }
}
