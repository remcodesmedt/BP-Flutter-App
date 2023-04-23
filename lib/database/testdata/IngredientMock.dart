import 'package:project_flutter/domain/EUnit.dart';

import '../../domain/Ingredient.dart';
import '../../domain/IngredientCategory.dart';
import '../interfaces/IngredientInterface.dart';

class IngredientMock {
  static Future<void> insertMocks() async {
    //create all mock ingredient objects, just use id=0, it doesn't matter because it's autoincrement
    final ingredients = [
      Ingredient(
          id: 0,
          name: "Appel",
          unit: EUnit.g,
          category: IngredientCategory(id: 2, name: "")),
      //only id matters really
      Ingredient(
          id: 0,
          name: "Melk",
          unit: EUnit.ml,
          category: IngredientCategory(id: 5, name: "")),
      Ingredient(
          id: 0,
          name: "Aardappel",
          unit: EUnit.g,
          category: IngredientCategory(id: 1, name: "")),
    ];

    //insert them into the db
    ingredients.forEach((ingredient) async {
      await IngredientInterface.insertItem(ingredient);
    });
  }

  static Future<String> getLogsMocks() async {
    String output = "";

    final ingredients = await IngredientInterface.getItems();

    for (final c in ingredients) {
      output +=
          "${c.id}: ${c.name}, unit: ${c.unit.toShortString()}, category: ${c.category.name}\n";
    }

    return output += "\n";
  }
}
