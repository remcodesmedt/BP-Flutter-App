import 'package:project_flutter/database/tables/ShoppingListTable.dart';

import '../../domain/EUnit.dart';
import '../../domain/Ingredient.dart';
import '../../domain/IngredientAmount.dart';
import '../../domain/IngredientCategory.dart';
import '../../domain/ShoppingList.dart';
import '../DBHelper.dart';
import '../tables/IngredientAmountTable.dart';
import '../tables/IngredientCategoryTable.dart';
import '../tables/IngredientTable.dart';

class ShoppingListInterface {
  static Future<List<ShoppingList>> getItems() async {
    final db = DBHelper.getDB();
    final columns = ShoppingListTable.COLUMNS_FOR_SELECT;
    const joinClause = ShoppingListTable.JOIN_CLAUSE;

    final res = await db.query(
        "${ShoppingListTable.TABLE_NAME}, ${IngredientAmountTable.TABLE_NAME}, " +
            "${IngredientTable.TABLE_NAME}, ${IngredientCategoryTable.TABLE_NAME}",
        columns: columns,
        where: joinClause,
        orderBy:
            "${ShoppingListTable.TABLE_NAME}.${ShoppingListTable.COLUMN_ID}");

    final shoppingLists = <ShoppingList>[];
    ShoppingList? currentShoppingList;

    res.forEach((Map<String, Object?> map) {
      final shoppingListId = map[ShoppingListTable.COLUMN_ID] as int;
      final shoppingListName = map[ShoppingListTable.COLUMN_NAME] as String;

      final ingredientAmountId = map[IngredientAmountTable.COLUMN_ID] as int;
      final ingredientAmount =
          map[IngredientAmountTable.COLUMN_AMOUNT] as double;

      final ingredientId = map[IngredientTable.COLUMN_ID] as int;
      final ingredientName = map[IngredientTable.COLUMN_NAME] as String;
      final ingredientUnit = map[IngredientTable.COLUMN_UNIT] as String;
      final unit = EUnitExtension.fromString(ingredientUnit);

      final ingredientCategoryId =
          map[IngredientCategoryTable.COLUMN_ID] as int;
      final ingredientCategoryName =
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

      // Check if we're still processing the same shopping list
      if (currentShoppingList?.id != shoppingListId) {
        // If not, add the previous shopping list to the result (if there was one)
        if (currentShoppingList != null) {
          shoppingLists.add(currentShoppingList!);
        }

        // Create new shopping list with this ingredient amount
        currentShoppingList = ShoppingList(
            id: shoppingListId,
            name: shoppingListName,
            ingredients: [ingredientAmountObj]);
      } else {
        // Add this ingredient amount to the current shopping list
        currentShoppingList?.ingredients.add(ingredientAmountObj);
      }
    });

    if (currentShoppingList != null) {
      shoppingLists.add(currentShoppingList!);
    }

    return shoppingLists;
  }

  static Future<void> insertItem(ShoppingList shoppingList) async {
    final db = DBHelper.getDB();

    final values = <String, Object>{
      ShoppingListTable.COLUMN_NAME: shoppingList.name,
    };

    var shoppingListId = await db.insert(ShoppingListTable.TABLE_NAME, values);

    shoppingList.ingredients.forEach((element) async {
      final ingrAmount = <String, Object>{
        IngredientAmountTable.COLUMN_AMOUNT: element.amount,
        IngredientAmountTable.COLUMN_SHOPPINGLIST_ID: shoppingListId,
        IngredientAmountTable.COLUMN_INGREDIENT_ID: element.ingredient.id
      };
      await db.insert(IngredientAmountTable.TABLE_NAME, ingrAmount);
    });
  }
}
