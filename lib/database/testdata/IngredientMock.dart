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
          name: "kweetni",
          unit: EUnit.g,
          category: IngredientCategory(id: 2, name: "")),
      //only id matters really
      Ingredient(
          id: 0,
          name: "kweetni part 2",
          unit: EUnit.ml,
          category: IngredientCategory(id: 5, name: "")),
      Ingredient(
          id: 0,
          name: "kweetni part 500",
          unit: EUnit.g,
          category: IngredientCategory(id: 6, name: "")),
    ];

    //insert them into the db
    ingredients.forEach((ingredient) async {
      await IngredientInterface.insertItem(ingredient);
    });
  }

  static Future<void> logMocks() async {
    print("Ingredient----------------------------------------");
    //get ingredients from the db
    final ingredients = await IngredientInterface.getItems();
    //just log them for now
    for (final c in ingredients) {
      print(
          "${c.id}: ${c.name}, unit: ${c.unit}, category: ${c.category.id} - ${c.category.name}");
    }
  }
}
