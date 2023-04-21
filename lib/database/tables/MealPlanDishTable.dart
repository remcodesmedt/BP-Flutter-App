import 'DishTable.dart';
import 'MealPlanTable.dart';

class MealPlanDishTable {
  static const String TABLE_NAME = "mealplan_dish";

  static const String COLUMN_ID = "mealplandishid";
  static const String COLUMN_MEALPLAN_ID = "mealplanid";
  static const String COLUMN_DISH_ID = "dishid";
  static const String COLUMN_DAY_OF_WEEK = "dayofweek";

  static const String CREATE_TABLE = """
        CREATE TABLE IF NOT EXISTS $TABLE_NAME (
            $COLUMN_ID INTEGER PRIMARY KEY AUTOINCREMENT,
            $COLUMN_MEALPLAN_ID INTEGER,
            $COLUMN_DISH_ID INTEGER,
            $COLUMN_DAY_OF_WEEK INTEGER,
            FOREIGN KEY ($COLUMN_MEALPLAN_ID) REFERENCES ${MealPlanTable
      .TABLE_NAME}(${MealPlanTable.COLUMN_ID}),
            FOREIGN KEY ($COLUMN_DISH_ID) REFERENCES ${DishTable
      .TABLE_NAME}(${DishTable.COLUMN_ID}),
            UNIQUE ($COLUMN_MEALPLAN_ID, $COLUMN_DAY_OF_WEEK)
        )
    """;

  static const String DROP_TABLE = "DROP TABLE IF EXISTS $TABLE_NAME";

  static final COLUMNS_FOR_SELECT = [
    COLUMN_ID,
    "$TABLE_NAME.$COLUMN_MEALPLAN_ID", //fk naar mealplantable
    "$TABLE_NAME.$COLUMN_DISH_ID", //fk naar dishtable
    COLUMN_DAY_OF_WEEK,
  ]..addAll(MealPlanTable.COLUMNS_FOR_SELECT)..addAll(
      DishTable.COLUMNS_FOR_SELECT);

  static const JOIN_CLAUSE = """
        ${MealPlanTable.TABLE_NAME}.${MealPlanTable.COLUMN_ID}
               = ${MealPlanDishTable.TABLE_NAME}.$COLUMN_MEALPLAN_ID
        AND
        ${DishTable.TABLE_NAME}.${DishTable.COLUMN_ID}
               = ${MealPlanDishTable.TABLE_NAME}.$COLUMN_DISH_ID
        AND
        ${DishTable.JOIN_CLAUSE}
    """;
}
