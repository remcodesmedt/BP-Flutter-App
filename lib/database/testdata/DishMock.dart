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
        description: "makkelijk te maken",
        image: img1,
        preparationTime: 10,
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
        description: "lekker!",
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
    dish2.name = "mijn derde dish";
    await DishInterface.insertItem(dish2);
  }

  static Future<String> getLogsMocks() async {
    String output = "";

    final dishes = await DishInterface.getItems();

    for (final dish in dishes) {
      output += "${dish.id}: ${dish.name}, ${dish.description}, " +
          "Tijd: ${dish.preparationTime}, Personen: ${dish.servings}\n";

      var i = 1;
      output += "instructies:\n";
      dish.instructions.forEach((instr) {
        output += "- Step ${i++}: $instr\n";
      });

      output += "ingredients:\n";
      dish.ingredients.forEach((ingr) {
        output +=
            "- ${ingr.ingredient.name}: ${ingr.amount}${ingr.ingredient.unit.toShortString()}\n";
      });
      output += "\n";
    }

    return output += "\n";
  }
}
