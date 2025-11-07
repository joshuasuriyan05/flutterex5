import 'package:flutter/material.dart';
import '../models/plan_data_model.dart';

class PlanResultScreen extends StatelessWidget {
  const PlanResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final plan = ModalRoute.of(context)!.settings.arguments as DailyPlan;
    final double used =
        plan.work + plan.exercise + plan.leisure + plan.sleep;
    final double remaining = plan.totalHours - used;

    String formatHours(double h) => '${h.toStringAsFixed(2)} hrs';

    return Scaffold(
      appBar: AppBar(
        title: const Text("Daily Plan Summary"),
        backgroundColor: Colors.amber,
        foregroundColor: Colors.white,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Card(
              elevation: 4,
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                leading: const Icon(Icons.schedule),
                title: const Text("Total Available Hours"),
                subtitle: Text(formatHours(plan.totalHours)),
              ),
            ),
            Card(
              elevation: 4,
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                leading: const Icon(Icons.work),
                title: const Text("Work"),
                subtitle: Text(formatHours(plan.work)),
              ),
            ),
            Card(
              elevation: 4,
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                leading: const Icon(Icons.fitness_center),
                title: const Text("Exercise"),
                subtitle: Text(formatHours(plan.exercise)),
              ),
            ),
            Card(
              elevation: 4,
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                leading: const Icon(Icons.self_improvement),
                title: const Text("Leisure / Personal Time"),
                subtitle: Text(formatHours(plan.leisure)),
              ),
            ),
            Card(
              elevation: 4,
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                leading: const Icon(Icons.bedtime),
                title: const Text("Sleep"),
                subtitle: Text(formatHours(plan.sleep)),
              ),
            ),
            Card(
              elevation: 4,
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                leading: const Icon(Icons.pie_chart_outline),
                title: const Text("Summary"),
                subtitle: Text("Used: ${formatHours(used)}"),
                trailing: remaining >= 0
                    ? Text(
                        "Free: ${formatHours(remaining)}",
                        style: const TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      )
                    : Text(
                        "Overbooked: ${formatHours(remaining)}",
                        style: const TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}