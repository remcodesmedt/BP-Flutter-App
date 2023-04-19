import 'dart:convert';
import 'dart:typed_data';

import 'package:project_flutter/database/tables/DishTable.dart';
import 'package:project_flutter/domain/EUnit.dart';

import '../../domain/Dish.dart';
import '../../domain/Ingredient.dart';
import '../../domain/IngredientAmount.dart';
import '../../domain/IngredientCategory.dart';
import '../DBHelper.dart';
import '../tables/IngredientAmountTable.dart';
import '../tables/IngredientCategoryTable.dart';
import '../tables/IngredientTable.dart';

class DishInterface {
  static Future<List<Dish>> getItems() async {
    final db = DBHelper.getDB();

    var columns = DishTable.COLUMNS_FOR_SELECT;
    var joinClause = DishTable.JOIN_CLAUSE;
    final res = await db.query(
        "${DishTable.TABLE_NAME}, ${IngredientAmountTable.TABLE_NAME},"
        "${IngredientTable.TABLE_NAME}, ${IngredientCategoryTable.TABLE_NAME}",
        columns: columns,
        where: joinClause,
        orderBy: "${DishTable.TABLE_NAME}.${DishTable.COLUMN_ID}");

    List<Dish> dishes = [];
    Dish? currentDish = null;

    res.forEach((Map<String, Object?> map) {
      var dishId = map[DishTable.COLUMN_ID] as int;
      var dishName = map[DishTable.COLUMN_NAME] as String;
      var dishDescription = map[DishTable.COLUMN_DESCRIPTION] as String;
      var dishImageList = map[DishTable.COLUMN_IMAGE] as List<int>;
      var dishImage = Uint8List.fromList(dishImageList);

      var dishPrepTime = map[DishTable.COLUMN_PREPARATION_TIME] as int;
      var dishServings = map[DishTable.COLUMN_SERVINGS] as int;
      var dishInstructionsString = map[DishTable.COLUMN_INSTRUCTIONS] as String;
      var dishInstructionsList =
          (jsonDecode(dishInstructionsString) as List<dynamic>).cast<String>();

      var ingredientAmountId = map[IngredientAmountTable.COLUMN_ID] as int;
      var ingredientAmount = map[IngredientAmountTable.COLUMN_AMOUNT] as double;

      var ingredientId = map[IngredientTable.COLUMN_ID] as int;
      var ingredientName = map[IngredientTable.COLUMN_NAME] as String;
      var ingredientUnit = map[IngredientTable.COLUMN_UNIT] as String;
      var unit = EUnitExtension.fromString(ingredientUnit);

      var ingredientCategoryId = map[IngredientCategoryTable.COLUMN_ID] as int;
      var ingredientCategoryName =
          map[IngredientCategoryTable.COLUMN_NAME] as String;

      // Create IngredientAmount object
      final ingredientAmountObj = IngredientAmount(
        id: ingredientAmountId,
        ingredient: Ingredient(
          id: ingredientId,
          name: ingredientName,
          unit: unit,
          category: IngredientCategory(
              id: ingredientCategoryId, name: ingredientCategoryName),
        ),
        amount: ingredientAmount,
      );

      // Check if we're still processing the same dish
      if (currentDish?.id != dishId) {
        // If not, add the previous dish to the result (if there was one)
        if (currentDish != null) {
          dishes.add(currentDish!);
        }

        // Create new shopping list with this ingredient amount
        currentDish = Dish(
            id: dishId,
            name: dishName,
            description: dishDescription,
            image: dishImage,
            preparationTime: dishPrepTime,
            servings: dishServings,
            instructions: dishInstructionsList,
            ingredients: [ingredientAmountObj]);
      } else {
        // Add this ingredient amount to the current shopping list
        currentDish?.ingredients.add(ingredientAmountObj);
      }
    });

    // Add the final dish to the result (if there was one)
    if (currentDish != null) {
      dishes.add(currentDish!);
    }

    return dishes;
  }

  static Future<void> insertItem(Dish dish) async {
    final db = DBHelper.getDB();

    final values = <String, Object>{
      DishTable.COLUMN_NAME: dish.name,
      DishTable.COLUMN_DESCRIPTION: dish.description ?? "",
      DishTable.COLUMN_IMAGE: dish.image,
      DishTable.COLUMN_PREPARATION_TIME: dish.preparationTime ?? 0,
      DishTable.COLUMN_SERVINGS: dish.servings,
      DishTable.COLUMN_INSTRUCTIONS: jsonEncode(dish.instructions)
    };

    var dishId = await db.insert(DishTable.TABLE_NAME, values);

    dish.ingredients.forEach((element) async {
      final ingrAmount = <String, Object>{
        IngredientAmountTable.COLUMN_AMOUNT: element.amount,
        IngredientAmountTable.COLUMN_DISH_ID: dishId,
        IngredientAmountTable.COLUMN_INGREDIENT_ID: element.ingredient.id
      };
      await db.insert(IngredientAmountTable.TABLE_NAME, ingrAmount);
    });
  }
}
