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
}
