import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// Update these imports if your files are under lib/screens/ or lib/models/
import 'package:ex5/screens/plan_details_screen.dart';
import 'package:ex5/screens/plan_result_screen.dart';

void main() {
  testWidgets('Daily Planner loads and has 5 input fields', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: const PlanDetailsScreen(),
        routes: {'/result': (context) => const PlanResultScreen()},
      ),
    );

    // AppBar title
    expect(find.text('Daily Planner App'), findsOneWidget);

    // There should be five TextFormField widgets (total, work, exercise, leisure, sleep)
    expect(find.byType(TextFormField), findsNWidgets(5));
    // Button exists
    expect(find.text('Calculate Plan'), findsOneWidget);
  });

  testWidgets('Submitting form navigates to summary with correct remaining hours', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) => const PlanDetailsScreen(),
          '/result': (context) => const PlanResultScreen(),
        },
      ),
    );

    // Enter values: total 24, work 8, exercise 1, leisure 3, sleep 8 => remaining = 24 - (8+1+3+8) = 4
    await tester.enterText(find.byType(TextFormField).at(0), '24'); // Total Available Hours
    await tester.enterText(find.byType(TextFormField).at(1), '8');  // Work
    await tester.enterText(find.byType(TextFormField).at(2), '1');  // Exercise
    await tester.enterText(find.byType(TextFormField).at(3), '3');  // Leisure
    await tester.enterText(find.byType(TextFormField).at(4), '8');  // Sleep

    // Tap the submit button
    await tester.tap(find.text('Calculate Plan'));
    await tester.pumpAndSettle(); // wait for navigation and animations

    // Result screen should appear
    expect(find.text('Daily Plan Summary'), findsOneWidget);

    // The result screen shows "Free: 4.00 hrs" when remaining = 4.00
    expect(find.text('Free: 4.00 hrs'), findsOneWidget);
  });
}