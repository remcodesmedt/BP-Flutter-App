import 'DishTable.dart';
import 'IngredientTable.dart';
import 'ShoppingListTable.dart';

class IngredientAmountTable {
  static const String TABLE_NAME = "ingredientamount";

  static const String COLUMN_ID = "ingredientamountid";
  static const String COLUMN_AMOUNT = "ingramount";
  static const String COLUMN_SHOPPINGLIST_ID = "shoppinglistid";
  static const String COLUMN_DISH_ID = "dishid";
  static const String COLUMN_INGREDIENT_ID = "ingredientid";

  static const String CREATE_TABLE = """
    CREATE TABLE IF NOT EXISTS $TABLE_NAME (
      $COLUMN_ID INTEGER PRIMARY KEY AUTOINCREMENT,
      $COLUMN_AMOUNT DOUBLE,
      $COLUMN_SHOPPINGLIST_ID INTEGER NULL,
      $COLUMN_DISH_ID INTEGER NULL,
      $COLUMN_INGREDIENT_ID INTEGER NOT NULL,

      FOREIGN KEY ($COLUMN_SHOPPINGLIST_ID)
        REFERENCES ${ShoppingListTable.TABLE_NAME}(${ShoppingListTable.COLUMN_ID}) ON DELETE CASCADE,

      FOREIGN KEY ($COLUMN_DISH_ID)
        REFERENCES ${DishTable.TABLE_NAME}(${DishTable.COLUMN_ID}) ON DELETE CASCADE,

      FOREIGN KEY ($COLUMN_INGREDIENT_ID)
        REFERENCES ${IngredientTable.TABLE_NAME}(${IngredientTable.COLUMN_ID}) ON DELETE CASCADE
    )
  """;

  static const String DROP_TABLE = "DROP TABLE IF EXISTS $TABLE_NAME";
}