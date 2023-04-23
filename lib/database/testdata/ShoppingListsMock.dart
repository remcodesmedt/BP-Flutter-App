import '../../domain/EUnit.dart';
import '../../domain/Ingredient.dart';
import '../../domain/IngredientAmount.dart';
import '../../domain/IngredientCategory.dart';
import '../../domain/ShoppingList.dart';
import '../interfaces/ShoppingListInterface.dart';

class ShoppingListMock {
  static Future<void> insertMocks() async {
    //for ingredient, only id matters, category could be anything rn
    final ingrAmount1 = IngredientAmount(
        id: 0, ingredient: Ingredient.withId(2), amount: 100.0);

    final ingrAmount2 =
        IngredientAmount(id: 0, ingredient: Ingredient.withId(1), amount: 50.0);

    final shoppingList1 = ShoppingList(
        id: 0, name: "Mijn lijst", ingredients: [ingrAmount1, ingrAmount2]);

    final shoppingList2 = ShoppingList(
        id: 0,
        name: "Mijn tweede lijst",
        ingredients: [ingrAmount2, ingrAmount1]);

    //insert list into db
    await ShoppingListInterface.insertItem(shoppingList1);
    await ShoppingListInterface.insertItem(shoppingList2);
  }

  static Future<String> getLogsMocks() async {
    String output = "";

    final shoppingLists = await ShoppingListInterface.getItems();

    for (final l in shoppingLists) {
      output += "${l.id}: ${l.name}: \n-ingredients:\n";
      for (final i in l.ingredients) {
        output +=
            "-- ${i.ingredient.name}: ${i.amount}${i.ingredient.unit.toShortString()}\n";
      }
      output += "\n";
    }

    return output += "\n";
  }
}
