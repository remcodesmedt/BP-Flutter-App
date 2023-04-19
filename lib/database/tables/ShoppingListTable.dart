import 'IngredientAmountTable.dart';
import 'IngredientCategoryTable.dart';
import 'IngredientTable.dart';

class ShoppingListTable {
  static const TABLE_NAME = "shoppinglist";

  static const COLUMN_ID = "shoppinglistid";
  static const COLUMN_NAME = "shoppinglistname";

  static const CREATE_TABLE = """
        CREATE TABLE IF NOT EXISTS $TABLE_NAME (
            $COLUMN_ID INTEGER PRIMARY KEY AUTOINCREMENT,
            $COLUMN_NAME TEXT
        )
    """;

  static const DROP_TABLE = "DROP TABLE IF EXISTS $TABLE_NAME";

  static final COLUMNS_FOR_SELECT = [
    "$TABLE_NAME.$COLUMN_ID",
    COLUMN_NAME,
    IngredientAmountTable.COLUMN_ID,
    IngredientAmountTable.COLUMN_AMOUNT,
    "${IngredientAmountTable.TABLE_NAME}.${IngredientAmountTable.COLUMN_SHOPPINGLIST_ID}",
    "${IngredientAmountTable.TABLE_NAME}.${IngredientAmountTable.COLUMN_INGREDIENT_ID}",
    "${IngredientTable.TABLE_NAME}.${IngredientTable.COLUMN_ID}",
    IngredientTable.COLUMN_NAME,
    IngredientTable.COLUMN_UNIT,
    "${IngredientTable.TABLE_NAME}.${IngredientTable.COLUMN_INGREDIENTCATEGORYID}",
    "${IngredientCategoryTable.TABLE_NAME}.${IngredientCategoryTable.COLUMN_ID}",
    IngredientCategoryTable.COLUMN_NAME
  ];

  static const JOIN_CLAUSE = """
            ${ShoppingListTable.TABLE_NAME}.${ShoppingListTable.COLUMN_ID} 
            = ${IngredientAmountTable.TABLE_NAME}.${IngredientAmountTable.COLUMN_SHOPPINGLIST_ID}
           AND
            ${IngredientAmountTable.TABLE_NAME}.${IngredientAmountTable.COLUMN_INGREDIENT_ID} 
            = ${IngredientTable.TABLE_NAME}.${IngredientTable.COLUMN_ID}
           AND
            ${IngredientTable.TABLE_NAME}.${IngredientTable.COLUMN_INGREDIENTCATEGORYID} 
            = ${IngredientCategoryTable.TABLE_NAME}.${IngredientCategoryTable.COLUMN_ID}
        """;
}
