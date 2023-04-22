import '../../domain/IngredientCategory.dart';
import '../interfaces/IngredientCategoryInterface.dart';

class IngredientCategoryMock {
  static Future<void> insertMocks() async {
    //create all mock ingredientcategory objects, just use id=0, it doesn't matter because it's autoincrement
    final ingredientCategories = [
      IngredientCategory(id: 0, name: "Vegetables"),
      IngredientCategory(id: 0, name: "Fruits"),
      IngredientCategory(id: 0, name: "Meat"),
      IngredientCategory(id: 0, name: "Fish"),
      IngredientCategory(id: 0, name: "Dairy"),
      IngredientCategory(id: 0, name: "Grains"),
      IngredientCategory(id: 0, name: "Spices"),
      IngredientCategory(id: 0, name: "Condiments"),
      IngredientCategory(id: 0, name: "Beverages"),
      IngredientCategory(id: 0, name: "Sweets"),
    ];

    //insert them into the db
    ingredientCategories.forEach((category) async {
      await IngredientCategoryInterface.insertItem(category);
    });
  }

  static Future<String> getMocksLogs() async {
    String output = "IngredientCategory----------\n";
    // print("IngredientCategory----------------------------------------");

    final categories = await IngredientCategoryInterface.getItems();

    for (final c in categories) {
      output += "${c.id}: ${c.name}\n";
      // print("${c.id}: ${c.name}");
    }

    return output+="\n";
  }
}
