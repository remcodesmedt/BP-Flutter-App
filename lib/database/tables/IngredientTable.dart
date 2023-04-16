import 'IngredientCategoryTable.dart';

class IngredientTable {
  static const String TABLE_NAME = "ingredient";

  static const String COLUMN_ID = "ingredientid";
  static const String COLUMN_NAME = "name";
  static const String COLUMN_UNIT = "unit";

  static const String COLUMN_INGREDIENTCATEGORY = "ingredientcategory";

  static const CREATE_TABLE = """
        CREATE TABLE IF NOT EXISTS $TABLE_NAME (
            $COLUMN_ID INTEGER PRIMARY KEY AUTOINCREMENT,
            $COLUMN_NAME TEXT,
            $COLUMN_UNIT TEXT,
            ${COLUMN_INGREDIENTCATEGORY} INTEGER NOT NULL,
                FOREIGN KEY (${COLUMN_INGREDIENTCATEGORY})
                REFERENCES ${IngredientCategoryTable.TABLE_NAME}(${IngredientCategoryTable.COLUMN_ID}) ON DELETE CASCADE
        )
    """;

  static const String DROP_TABLE = "DROP TABLE IF EXISTS $TABLE_NAME";
}
