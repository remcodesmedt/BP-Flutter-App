import 'package:project_flutter/database/interfaces/MealPlanInterface.dart';
import 'package:project_flutter/domain/EUnit.dart';

import '../../domain/Dish.dart';
import '../../domain/MealPlan.dart';

class MealPlanMock {
  static Future<void> insertMocks() async {
    final startDate = DateTime(2023, 4, 17);
    final endDate = DateTime(2023, 4, 23);

    //only id's matter here
    final dish1 = Dish.withId(1);
    final dish2 = Dish.withId(2);
    final dish3 = Dish.withId(3);

    final mealplan = MealPlan(
      id: 0,
      startDate: startDate,
      endDate: endDate,
    );
    mealplan.dishes = [dish1, dish2, dish1, dish2, dish1, dish2, dish3];

    final mealplan2 = MealPlan(
      id: 0,
      startDate: startDate.add(Duration(days: 7)),
      endDate: endDate.add(Duration(days: 7)),
    );
    mealplan2.dishes = [dish1, dish2, dish1, dish2, dish1, dish2, dish3];

    await MealPlanInterface.insertItem(mealplan);
    await MealPlanInterface.insertItem(mealplan2);
  }

  static Future<String> getLogsMocks() async {
    String output = "";
    // print("MealPlan----------------------------------------");

    final mealPlans = await MealPlanInterface.getItems(null);

    mealPlans.forEach((mealPlan) {
      output +=
          "mealplan ${mealPlan.id}: week van ${mealPlan.startDate.toString().substring(0, 10)}"
          " - ${mealPlan.endDate.toString().substring(0, 10)}\n";
      // print(
      //     "mealplan ${mealPlan.id}: week van ${mealPlan.startDate} - ${mealPlan.endDate}");

      int i = 1;
      mealPlan.dishes.forEach((dish) {
        output += "-Dish ${i++}: \n";
        // print("-Dish ${i++}: ");
        dish.ingredients.forEach((ingr) {
          output +=
              "--${ingr.ingredient.name}: ${ingr.amount}${ingr.ingredient.unit.toShortString()}\n";
          // print(
          //     "--${ingr.ingredient.name}: ${ingr.amount}${ingr.ingredient.unit.toShortString()}");
        });
      });
      output += "\n";
    });

    return output += "\n";
  }
}
