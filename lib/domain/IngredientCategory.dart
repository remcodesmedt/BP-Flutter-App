class IngredientCategory {
  int id;
  String name;

  IngredientCategory({
    required this.id,
    required this.name,
  });

  IngredientCategory.withId(this.id) : name = "";
}
