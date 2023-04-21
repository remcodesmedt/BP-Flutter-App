class MealPlanTable {
  static const String TABLE_NAME = "mealplan";

  static const String COLUMN_ID = "mealplanid";
  static const String COLUMN_START_DATE = "mpstartdate";
  static const String COLUMN_END_DATE = "mpenddate";

  static const String CREATE_TABLE = """
        CREATE TABLE IF NOT EXISTS $TABLE_NAME (
            $COLUMN_ID INTEGER PRIMARY KEY AUTOINCREMENT,
            $COLUMN_START_DATE DATE,
            $COLUMN_END_DATE DATE
        )
    """;

  static const String DROP_TABLE = "DROP TABLE IF EXISTS $TABLE_NAME";

  static const COLUMNS_FOR_SELECT = [
    "${TABLE_NAME}.${COLUMN_ID}",
    "${TABLE_NAME}.${COLUMN_START_DATE}",
    "${TABLE_NAME}.${COLUMN_END_DATE}",
  ];
}
