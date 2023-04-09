import 'Dish.dart';

class MealPlan {
  DateTime startDate;
  DateTime endDate;
  List<Dish?> dishes;

  MealPlan({
    required this.startDate,
    required this.endDate,
  }) : dishes = List<Dish?>.filled(7, null);
}

