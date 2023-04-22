import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_flutter/database/interfaces/DishInterface.dart';
import 'package:project_flutter/domain/Dish.dart';

import '../../domain/EUnit.dart';
import '../../domain/Ingredient.dart';
import '../../domain/IngredientAmount.dart';
import '../../domain/IngredientCategory.dart';

class DishMock {
  static Future<Uint8List> imageToUint8List(String imagepath) async {
    var res = await rootBundle.load(imagepath);
    return res.buffer.asUint8List();
  }

  static Future<void> insertMocks() async {
    //for ingredient, only id matters, category could be anything rn
    final ingrAmount1 = IngredientAmount(
        id: 0, ingredient: Ingredient.withId(2), amount: 125.0);

    final ingrAmount2 = IngredientAmount(
        id: 0, ingredient: Ingredient.withId(1), amount: 200.0);

    //images as bytearray
    var img1 = await imageToUint8List("assets/images/dishImg1.jpg");
    var img2 = await imageToUint8List("assets/images/dishImg2.jpg");

    //dishes
    var dish1 = Dish(
        id: 0,
        name: "mijn dish",
        description: "leuke dish",
        image: img1,
        preparationTime: 15,
        servings: 2,
        instructions: [
          "verwarm de oven voor",
          "zet de ingredienten in de oven",
          "bon appetit"
        ],
        ingredients: [
          ingrAmount1,
          ingrAmount2
        ]);

    var dish2 = Dish(
        id: 0,
        name: "mijn tweede dish",
        description: "minder leuke dish",
        image: img2,
        preparationTime: 30,
        servings: 1,
        instructions: [
          "koude oven",
          "zet de ingredienten in de oven",
          "10min op 200°C",
          "smakelijk"
        ],
        ingredients: [
          ingrAmount2,
          ingrAmount1
        ]);

    //insert list into db
    await DishInterface.insertItem(dish1);
    await DishInterface.insertItem(dish2);
    dish2.name = "mijnen derde zeker";
    await DishInterface.insertItem(dish2);
  }

  static Future<Dish> logMocks() async {
    print("Shoppinglist----------------------------------------");

    //get dishes from the db
    final dishes = await DishInterface.getItems();

    //just log them for now
    for (final dish in dishes) {
      print("${dish.id}: ${dish.name}, ${dish.description}, ${dish.image}, " +
          "${dish.preparationTime}, ${dish.servings}");

      var i = 1;
      print("instructions:\n");
      dish.instructions?.forEach((instr) {
        print("- Step ${i++}: $instr");
      });

      print("ingredients:\n");
      dish.ingredients.forEach((ingr) {
        print(
            "- ${ingr.ingredient.name}: ${ingr.amount}${ingr.ingredient.unit.toShortString()}");
      });
    }
    return dishes.first;
  }
}
