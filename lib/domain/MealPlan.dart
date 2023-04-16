import 'Dish.dart';

class MealPlan {
  int id;
  DateTime startDate;
  DateTime endDate;
  List<Dish?> dishes;

  MealPlan({
    required this.id,
    required this.startDate,
    required this.endDate,
  }) : dishes = List<Dish?>.filled(7, null);
}

