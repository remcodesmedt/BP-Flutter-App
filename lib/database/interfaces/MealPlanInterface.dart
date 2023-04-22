import 'dart:convert';
import 'dart:typed_data';

import 'package:project_flutter/database/tables/MealPlanDishTable.dart';
import 'package:project_flutter/domain/MealPlan.dart';

import '../../domain/Dish.dart';
import '../../domain/EUnit.dart';
import '../../domain/Ingredient.dart';
import '../../domain/IngredientAmount.dart';
import '../../domain/IngredientCategory.dart';
import '../DBHelper.dart';
import '../tables/DishTable.dart';
import '../tables/IngredientAmountTable.dart';
import '../tables/IngredientCategoryTable.dart';
import '../tables/IngredientTable.dart';
import '../tables/MealPlanTable.dart';

class MealPlanInterface {
  static Future<List<MealPlan>> getItems(DateTime? date) async {
    final db = DBHelper.getDB();

    final columns = MealPlanDishTable.COLUMNS_FOR_SELECT;
    final joinClause = MealPlanDishTable.JOIN_CLAUSE;

    final filterDate = date != null;

    var selection = joinClause;
    List<String>? selectionArgs = null;
    if (filterDate) {
      selection +=
          " AND ${MealPlanTable.TABLE_NAME}.${MealPlanTable.COLUMN_START_DATE} <= DATE(?) AND ${MealPlanTable.TABLE_NAME}.${MealPlanTable.COLUMN_END_DATE} >= DATE(?)";
      selectionArgs = [date.toString(), date.toString()];
    }

    final res = await db.query(
        "${MealPlanTable.TABLE_NAME}, ${MealPlanDishTable.TABLE_NAME}, ${DishTable.TABLE_NAME}, ${IngredientAmountTable.TABLE_NAME}, " +
            "${IngredientTable.TABLE_NAME}, ${IngredientCategoryTable.TABLE_NAME}",
        columns: columns,
        where: selection,
        whereArgs: selectionArgs,
        orderBy: "${MealPlanDishTable.TABLE_NAME}.${MealPlanDishTable.COLUMN_MEALPLAN_ID}, "
            "${MealPlanDishTable.TABLE_NAME}.${MealPlanDishTable.COLUMN_DISH_ID}");

    List<MealPlan> mealplans = [];
    MealPlan? currentMealPlan;
    List<Dish> currentDishes = [];
    Dish? currentDish;

    res.forEach((Map<String, Object?> map) {
      var mealPlanId = map[MealPlanTable.COLUMN_ID] as int;
      var mpStartDateString = map[MealPlanTable.COLUMN_START_DATE] as String;
      var mpEndDateString = map[MealPlanTable.COLUMN_END_DATE] as String;
      var mpStartDate = DateTime.parse(mpStartDateString);
      var mpEndDate = DateTime.parse(mpEndDateString);

      var dishId = map[DishTable.COLUMN_ID] as int;
      var dishName = map[DishTable.COLUMN_NAME] as String;
      var dishDescription = map[DishTable.COLUMN_DESCRIPTION] as String;
      var dishImageList = map[DishTable.COLUMN_IMAGE] as List<int>;
      var dishImage = Uint8List.fromList(dishImageList);

      var dishPrepTime = map[DishTable.COLUMN_PREPARATION_TIME] as int;
      var dishServings = map[DishTable.COLUMN_SERVINGS] as int;
      var dishInstructionsString = map[DishTable.COLUMN_INSTRUCTIONS] as String;
      var dishInstructionsList =
          (jsonDecode(dishInstructionsString) as List<dynamic>).cast<String>();

      var ingredientAmountId = map[IngredientAmountTable.COLUMN_ID] as int;
      var ingredientAmount = map[IngredientAmountTable.COLUMN_AMOUNT] as double;

      var ingredientId = map[IngredientTable.COLUMN_ID] as int;
      var ingredientName = map[IngredientTable.COLUMN_NAME] as String;
      var ingredientUnit = map[IngredientTable.COLUMN_UNIT] as String;
      var unit = EUnitExtension.fromString(ingredientUnit);

      var ingredientCategoryId = map[IngredientCategoryTable.COLUMN_ID] as int;
      var ingredientCategoryName =
          map[IngredientCategoryTable.COLUMN_NAME] as String;

      // Create IngredientAmount object
      final ingredientAmountObj = IngredientAmount(
        id: ingredientAmountId,
        ingredient: Ingredient(
          id: ingredientId,
          name: ingredientName,
          unit: unit,
          category: IngredientCategory(
              id: ingredientCategoryId, name: ingredientCategoryName),
        ),
        amount: ingredientAmount,
      );

      // Check if we're still processing the same mealplan
      if (currentMealPlan?.id != mealPlanId) {
        // If not, add the previous mealplan to the result (if there was one)
        if (currentMealPlan != null) {
          if (currentDish != null){
            currentDishes.add(currentDish!);
          }
          currentMealPlan!.dishes = currentDishes.toList();
          mealplans.add(currentMealPlan!);
          currentDishes.clear();
        }

        // Create new mealplan with new dish
        currentDish = Dish(
            id: dishId,
            name: dishName,
            description: dishDescription,
            image: dishImage,
            preparationTime: dishPrepTime,
            servings: dishServings,
            instructions: dishInstructionsList,
            ingredients: [ingredientAmountObj]);

        currentMealPlan = MealPlan(
            id: mealPlanId, startDate: mpStartDate, endDate: mpEndDate);
        currentMealPlan!.dishes = [currentDish!];
      } else {
        //same mealplan, so update the dishes OR update the dish its ingredients
        // Check if we're still processing the same dish
        if (currentDish?.id != dishId) {
          // If not, add the previous dish to the result (if there was one)
          if (currentDish != null) {
            currentDishes.add(currentDish!);
          }

          // Create new dish with this ingredient amount
          currentDish = Dish(
              id: dishId,
              name: dishName,
              description: dishDescription,
              image: dishImage,
              preparationTime: dishPrepTime,
              servings: dishServings,
              instructions: dishInstructionsList,
              ingredients: [ingredientAmountObj]);
        } else {
          //update dish
          currentDish?.ingredients.add(ingredientAmountObj);
        }
      }
    });

    // Add the final mealplan to the result (if there was one)
    if (currentMealPlan != null) {
      if (currentDish != null){
        currentDishes.add(currentDish!);
      }
      currentMealPlan!.dishes = currentDishes.toList();
      mealplans.add(currentMealPlan!);
      currentDishes.clear();
    }

    return mealplans;
  }

  static Future<void> insertItem(MealPlan mealPlan) async {
    if (mealPlan.dishes.contains(null)) {
      print("no null dishes!");
      throw Error();
    }

    final db = DBHelper.getDB();

    // Create a ContentValues object to hold the values to insert
    final values = <String, Object>{
      MealPlanTable.COLUMN_START_DATE: mealPlan.startDate.toString(),
      MealPlanTable.COLUMN_END_DATE: mealPlan.endDate.toString(),
    };

    // Insert the values into the IngredientCategoryTable
    final mealPlanId = await db.insert(MealPlanTable.TABLE_NAME, values);

    //dont insert dishes, but new table to link mealplan to 7 dishes
    int i = 0;
    mealPlan.dishes.forEach((dish) {
      final values = <String, Object>{
        MealPlanDishTable.COLUMN_MEALPLAN_ID: mealPlanId,
        MealPlanDishTable.COLUMN_DISH_ID: dish!.id,
        MealPlanDishTable.COLUMN_DAY_OF_WEEK: i++
      };

      db.insert(MealPlanDishTable.TABLE_NAME, values);
    });
  }
}
