import 'package:flutter/material.dart';
import 'package:project_flutter/database/testdata/MealPlanMock.dart';

class Planning extends StatefulWidget {
  const Planning({Key? key}) : super(key: key);

  @override
  State<Planning> createState() => _PlanningState();
}

class _PlanningState extends State<Planning> {
  String displayText = "Planning";

  @override
  void initState() {
    super.initState();
    getLogs();
  }

  Future<void> getLogs() async {
    try {
      String output = await MealPlanMock.getLogsMocks();
      if (output.trim().isEmpty) output = "Nog geen data!";
      setState(() {
        displayText = output;
      });
    } catch (e) {
      setState(() {
        displayText = "Databank nog niet aangemaakt!";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Text(
        displayText,
      ),
    );
  }
}
