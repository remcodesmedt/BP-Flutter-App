import 'IngredientAmount.dart';

class ShoppingList {
  int id;
  String name;
  List<IngredientAmount> ingredients;

  ShoppingList({
    required this.id,
    required this.name,
    required this.ingredients,
  });
}
