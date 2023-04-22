import '../../domain/EUnit.dart';
import '../../domain/Ingredient.dart';
import '../../domain/IngredientAmount.dart';
import '../../domain/IngredientCategory.dart';
import '../../domain/ShoppingList.dart';
import '../interfaces/ShoppingListInterface.dart';

class ShoppingListMock {
  static Future<void> insertMocks() async {
    //for ingredient, only id matters, category could be anything rn
    final ingrAmount1 =
        IngredientAmount(id: 0, ingredient: Ingredient.withId(2), amount: 25.0);

    final ingrAmount2 =
        IngredientAmount(id: 0, ingredient: Ingredient.withId(1), amount: 15.0);

    final shoppingList1 = ShoppingList(
        id: 0, name: "mijne lijst", ingredients: [ingrAmount1, ingrAmount2]);
    final shoppingList2 = ShoppingList(
        id: 0,
        name: "mijne lijst part 2",
        ingredients: [ingrAmount2, ingrAmount1]);

    //insert list into db
    await ShoppingListInterface.insertItem(shoppingList1);
    await ShoppingListInterface.insertItem(shoppingList2);
  }

  static Future<void> logMocks() async {
    print("Shoppinglist----------------------------------------");

    //get shoppinglists from the db
    final shoppingLists = await ShoppingListInterface.getItems();

    //just log them for now
    for (final l in shoppingLists) {
      print("${l.id}: ${l.name}, \ningredients:");
      for (final i in l.ingredients) {
        print(
            "- ${i.ingredient.name}: ${i.amount}${i.ingredient.unit.toShortString()}");
      }
    }
  }
}
