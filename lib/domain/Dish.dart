import 'dart:typed_data';

import 'package:project_flutter/domain/IngredientAmount.dart';

class Dish {
  int id;
  String name;
  String? description;
  Uint8List image;
  int? preparationTime;
  int servings;
  List<String>? instructions;
  List<IngredientAmount> ingredients;

  Dish({
    required this.id,
    required this.name,
    this.description,
    required this.image,
    this.preparationTime,
    required this.servings,
    this.instructions,
    required this.ingredients,
  });

  Dish.withId(this.id)
      : name = '',
        image = Uint8List(0),
        servings = 0,
        ingredients = [];
}
