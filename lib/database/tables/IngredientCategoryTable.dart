class IngredientCategoryTable {
  static const String TABLE_NAME = "ingredientcategory";

  static const String COLUMN_ID = "ingredientcategoryid";
  static const String COLUMN_NAME = "name";

  static const String CREATE_TABLE = """
    CREATE TABLE IF NOT EXISTS $TABLE_NAME (
      $COLUMN_ID INTEGER PRIMARY KEY AUTOINCREMENT,
      $COLUMN_NAME TEXT
    )
  """;

  static const String DROP_TABLE = "DROP TABLE IF EXISTS $TABLE_NAME";

  static const COLUMNS_FOR_SELECT = [
    IngredientCategoryTable.COLUMN_ID,
    IngredientCategoryTable.COLUMN_NAME
  ];
}
