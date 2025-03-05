import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sajilotantra/features/home/presentation/view/bottom_view/setting.dart';

void main() {
  // Group tests for better organization
  group('Setting Page Widget Tests', () {
    // Test 1: Check if the Setting page renders correctly
    testWidgets('Setting page renders correctly', (WidgetTester tester) async {
      // Build the widget
      await tester.pumpWidget(
        const MaterialApp(
          home: Setting(),
        ),
      );

      // Verify that the "Dark Mode" title is present
      expect(find.text('Dark Mode'), findsOneWidget);

      // Verify that the subtitle is present
      expect(find.text('Toggle between light and dark themes'), findsOneWidget);

      // Verify that the Switch widget is present
      expect(find.byType(Switch), findsOneWidget);
    });

    // Test 2: Check the initial state of the Switch and toggle it
    testWidgets('Switch toggles correctly', (WidgetTester tester) async {
      // Build the widget
      await tester.pumpWidget(
        const MaterialApp(
          home: Setting(),
        ),
      );

      // Find the Switch widget
      final switchFinder = find.byType(Switch);

      // Verify the initial state of the Switch (should be false)
      Switch switchWidget = tester.widget(switchFinder);
      expect(switchWidget.value, false);

      // Tap the Switch to toggle it
      await tester.tap(switchFinder);
      await tester.pump(); // Rebuild the widget after the state change

      // Verify the new state of the Switch (should be true)
      switchWidget = tester.widget(switchFinder);
      expect(switchWidget.value, true);

      // Tap the Switch again to toggle it back
      await tester.tap(switchFinder);
      await tester.pump(); // Rebuild the widget after the state change

      // Verify the state of the Switch (should be false again)
      switchWidget = tester.widget(switchFinder);
      expect(switchWidget.value, false);
    });
  });
}
