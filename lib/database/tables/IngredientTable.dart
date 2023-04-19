import 'IngredientCategoryTable.dart';

class IngredientTable {
  static const String TABLE_NAME = "ingredient";

  static const String COLUMN_ID = "ingredientid";
  static const String COLUMN_NAME = "ingredientname";
  static const String COLUMN_UNIT = "unit";

  static const String COLUMN_INGREDIENTCATEGORYID = "ingredientcategory";

  static const CREATE_TABLE = """
        CREATE TABLE IF NOT EXISTS $TABLE_NAME (
            $COLUMN_ID INTEGER PRIMARY KEY AUTOINCREMENT,
            $COLUMN_NAME TEXT,
            $COLUMN_UNIT TEXT,
            ${COLUMN_INGREDIENTCATEGORYID} INTEGER NOT NULL,
                FOREIGN KEY (${COLUMN_INGREDIENTCATEGORYID})
                REFERENCES ${IngredientCategoryTable.TABLE_NAME}(${IngredientCategoryTable.COLUMN_ID}) ON DELETE CASCADE
        )
    """;

  static const String DROP_TABLE = "DROP TABLE IF EXISTS $TABLE_NAME";

  static const List<String> COLUMNS_FOR_SELECT = [
    IngredientTable.COLUMN_ID,
    "${IngredientTable.TABLE_NAME}.${IngredientTable.COLUMN_NAME}",
    IngredientTable.COLUMN_UNIT,
    "${IngredientCategoryTable.TABLE_NAME}.${IngredientCategoryTable.COLUMN_NAME} AS category_name",
    "${IngredientTable.TABLE_NAME}.${IngredientTable.COLUMN_INGREDIENTCATEGORYID}"
  ];

  static const String JOIN_CLAUSE = "${IngredientTable.TABLE_NAME} INNER JOIN "
      "${IngredientCategoryTable.TABLE_NAME} "
      "ON ${IngredientTable.TABLE_NAME}.${IngredientTable.COLUMN_INGREDIENTCATEGORYID} "
      "= ${IngredientCategoryTable.TABLE_NAME}.${IngredientCategoryTable.COLUMN_ID}";
}
