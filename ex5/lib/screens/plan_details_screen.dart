import 'package:flutter/material.dart';
import '../models/plan_data_model.dart';

class PlanDetailsScreen extends StatefulWidget {
  const PlanDetailsScreen({super.key});

  @override
  State<PlanDetailsScreen> createState() => _PlanDetailsScreenState();
}

class _PlanDetailsScreenState extends State<PlanDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _totalController = TextEditingController();
  final _workController = TextEditingController();
  final _exerciseController = TextEditingController();
  final _leisureController = TextEditingController();
  final _sleepController = TextEditingController();

  @override
  void dispose() {
    _totalController.dispose();
    _workController.dispose();
    _exerciseController.dispose();
    _leisureController.dispose();
    _sleepController.dispose();
    super.dispose();
  }

  String? _validatePositiveNumber(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) return 'Enter $fieldName';
    final parsed = double.tryParse(value);
    if (parsed == null) return 'Enter a valid number';
    if (parsed < 0) return 'Enter a non-negative number';
    return null;
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final plan = DailyPlan(
        totalHours: double.parse(_totalController.text),
        work: double.parse(_workController.text),
        exercise: double.parse(_exerciseController.text),
        leisure: double.parse(_leisureController.text),
        sleep: double.parse(_sleepController.text),
      );

      Navigator.pushNamed(context, '/result', arguments: plan);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Planner App'),
        backgroundColor: Colors.amber,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: _totalController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                    labelText: "Total Available Hours (per day)",
                    border: OutlineInputBorder(),
                  ),
                  validator: (v) => _validatePositiveNumber(v, 'total available hours'),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _workController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                    labelText: "Work Hours",
                    border: OutlineInputBorder(),
                  ),
                  validator: (v) => _validatePositiveNumber(v, 'work hours'),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _exerciseController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                    labelText: "Exercise Hours",
                    border: OutlineInputBorder(),
                  ),
                  validator: (v) => _validatePositiveNumber(v, 'exercise hours'),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _leisureController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                    labelText: "Leisure / Personal Time (Hours)",
                    border: OutlineInputBorder(),
                  ),
                  validator: (v) => _validatePositiveNumber(v, 'leisure hours'),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _sleepController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                    labelText: "Sleep Hours",
                    border: OutlineInputBorder(),
                  ),
                  validator: (v) => _validatePositiveNumber(v, 'sleep hours'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: _submit,
                  child: const Text("Calculate Plan"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}