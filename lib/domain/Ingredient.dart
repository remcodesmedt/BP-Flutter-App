import 'package:project_flutter/domain/IngredientCategory.dart';

import 'EUnit.dart';

class Ingredient {
  int id;
  String name;
  EUnit unit;
  IngredientCategory category;

  Ingredient({
    required this.id,
    required this.name,
    required this.unit,
    required this.category,
  });

  Ingredient.withId(this.id)
      : name = "",
        unit = EUnit.g,
        category = IngredientCategory.withId(0);
}
