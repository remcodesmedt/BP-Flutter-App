import 'dart:typed_data';

import 'package:project_flutter/domain/IngredientAmount.dart';
import 'package:project_flutter/domain/Tag.dart';

class Dish {
  String name;
  String? description;
  Uint8List image;
  int? preparationTime;
  int servings;
  List<String>? instructions;
  List<IngredientAmount> ingredients;
  List<Tag>? tags;

  Dish({
    required this.name,
    this.description,
    required this.image,
    this.preparationTime,
    required this.servings,
    this.instructions,
    required this.ingredients,
    this.tags,
  });
}
