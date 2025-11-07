import 'package:flutter/material.dart';
import '../screens/plan_details_screen.dart';
import './screens/plan_result_screen.dart';

void main() {
  runApp(MaterialApp(
    title: "Daily Planner App",
    initialRoute: '/',
    routes: {
      '/': (context) => const PlanDetailsScreen(),
      '/result': (context) => const PlanResultScreen(),
    },
  ));
}