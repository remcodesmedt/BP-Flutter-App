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

    var columns = IngredientTable.COLUMNS_FOR_SELECT;

    var joinClause = IngredientTable.JOIN_CLAUSE;

    final res =
        await db.rawQuery("SELECT ${columns.join(',')} FROM $joinClause");

    List<Ingredient> ingredients = [];

    res.forEach((Map<String, Object?> map) {
      var id = map[IngredientTable.COLUMN_ID] as int;
      var name = map[IngredientTable.COLUMN_NAME] as String;
      var unitString = map[IngredientTable.COLUMN_UNIT] as String;
      var categoryid = map[IngredientTable.COLUMN_INGREDIENTCATEGORYID] as int;
      var categoryname = map["category_name"] as String;
      var unit = EUnitExtension.fromString(unitString);

      ingredients.add(Ingredient(
        id: id,
        name: name,
        unit: unit,
        category: IngredientCategory(id: categoryid, name: categoryname),
      ));
    });

    return ingredients;
  }

  static Future<void> insertItem(Ingredient ingredient) async {
    final db = DBHelper.getDB();

    final values = <String, Object>{
      IngredientTable.COLUMN_NAME: ingredient.name,
      IngredientTable.COLUMN_UNIT: ingredient.unit.toShortString(),
      IngredientTable.COLUMN_INGREDIENTCATEGORYID: ingredient.category.id
    };

    await db.insert(IngredientTable.TABLE_NAME, values);
  }
}
