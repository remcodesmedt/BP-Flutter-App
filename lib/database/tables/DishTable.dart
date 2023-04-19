import 'IngredientAmountTable.dart';
import 'IngredientCategoryTable.dart';
import 'IngredientTable.dart';

class DishTable {
  static const String TABLE_NAME = "dish";

  static const String COLUMN_ID = "dishid";
  static const String COLUMN_NAME = "dishname";
  static const String COLUMN_DESCRIPTION = "dishdescription";
  static const String COLUMN_IMAGE = "dishimage";
  static const String COLUMN_PREPARATION_TIME = "preparationTime";
  static const String COLUMN_SERVINGS = "servings";
  static const String COLUMN_INSTRUCTIONS = "instructions";

  static const String CREATE_TABLE = """
    CREATE TABLE IF NOT EXISTS $TABLE_NAME (
      $COLUMN_ID INTEGER PRIMARY KEY AUTOINCREMENT,
      $COLUMN_NAME TEXT,
      $COLUMN_DESCRIPTION TEXT,
      $COLUMN_IMAGE BLOB,
      $COLUMN_PREPARATION_TIME INTEGER,
      $COLUMN_SERVINGS INTEGER,
      $COLUMN_INSTRUCTIONS TEXT
    )
  """;

  static const String DROP_TABLE = "DROP TABLE IF EXISTS $TABLE_NAME";

  static const COLUMNS_FOR_SELECT = [
    "$TABLE_NAME.$COLUMN_ID",
    COLUMN_NAME,
    COLUMN_DESCRIPTION,
    COLUMN_IMAGE,
    COLUMN_PREPARATION_TIME,
    COLUMN_SERVINGS,
    COLUMN_INSTRUCTIONS,

    //ingredientamount
    "${IngredientAmountTable.TABLE_NAME}.${IngredientAmountTable.COLUMN_ID}",
    "${IngredientAmountTable.TABLE_NAME}.${IngredientAmountTable.COLUMN_AMOUNT}",
    "${IngredientAmountTable.TABLE_NAME}.${IngredientAmountTable.COLUMN_DISH_ID}", //=id of this table
    "${IngredientAmountTable.TABLE_NAME}.${IngredientAmountTable.COLUMN_INGREDIENT_ID}", //=id of table ingredient

    //ingredient
    "${IngredientTable.TABLE_NAME}.${IngredientTable.COLUMN_ID}",
    "${IngredientTable.TABLE_NAME}.${IngredientTable.COLUMN_NAME}",
    "${IngredientTable.TABLE_NAME}.${IngredientTable.COLUMN_UNIT}",
    "${IngredientTable.TABLE_NAME}.${IngredientTable.COLUMN_INGREDIENTCATEGORYID}", //=id of table ingredientcategory

    //ingredientCategory
    "${IngredientCategoryTable.TABLE_NAME}.${IngredientCategoryTable.COLUMN_ID}",
    "${IngredientCategoryTable.TABLE_NAME}.${IngredientCategoryTable.COLUMN_NAME}"
  ];

  static const JOIN_CLAUSE = """
        $TABLE_NAME.$COLUMN_ID
            = ${IngredientAmountTable.TABLE_NAME}.${IngredientAmountTable.COLUMN_DISH_ID}
        AND
        ${IngredientAmountTable.TABLE_NAME}.${IngredientAmountTable.COLUMN_INGREDIENT_ID} 
            = ${IngredientTable.TABLE_NAME}.${IngredientTable.COLUMN_ID}
        AND
        ${IngredientTable.TABLE_NAME}.${IngredientTable.COLUMN_INGREDIENTCATEGORYID} 
            = ${IngredientCategoryTable.TABLE_NAME}.${IngredientCategoryTable.COLUMN_ID}
  """;
}
