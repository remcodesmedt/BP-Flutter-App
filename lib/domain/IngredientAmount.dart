import 'package:project_flutter/domain/Ingredient.dart';

class IngredientAmount {
  int id;
  Ingredient ingredient;
  double amount;

  IngredientAmount({
    required this.id,
    required this.ingredient,
    required this.amount,
  });
}
