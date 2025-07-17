// Test for POS Flutter App Touch Responsiveness
//
// This test validates that the test mode interface is touchable and responsive.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_pos_responsive_app/main.dart';
import 'package:flutter_pos_responsive_app/core/constants/variables.dart';

void main() {
  group('Test Mode Touch Responsiveness', () {
    testWidgets('Test mode screen should display and buttons should be touchable', (WidgetTester tester) async {
      // Ensure test mode is enabled
      expect(Variables.isTestMode, true, reason: 'Test mode should be enabled for this test');

      // Build our app and trigger a frame.
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      // Verify that test mode welcome screen is displayed
      expect(find.text('TEST MODE ACTIVE'), findsOneWidget);
      expect(find.text('Start Testing'), findsOneWidget);
      expect(find.text('Use Login'), findsOneWidget);

      // Test that Start Testing button is touchable
      final startTestingButton = find.text('Start Testing');
      expect(startTestingButton, findsOneWidget);
      
      // Verify button is enabled and touchable
      final button = tester.widget<ElevatedButton>(find.ancestor(
        of: startTestingButton,
        matching: find.byType(ElevatedButton),
      ));
      expect(button.onPressed, isNotNull, reason: 'Start Testing button should be enabled');

      // Test tap on Start Testing button
      await tester.tap(startTestingButton);
      await tester.pumpAndSettle();

      // Should navigate to main navigation page
      expect(find.text('POS'), findsOneWidget);
      expect(find.text('Jobs'), findsOneWidget);
      expect(find.text('Customers'), findsOneWidget);
    });

    testWidgets('Bottom navigation should be touchable in test mode', (WidgetTester tester) async {
      // Build app and navigate to main navigation
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();
      
      // Tap Start Testing to get to main navigation
      await tester.tap(find.text('Start Testing'));
      await tester.pumpAndSettle();

      // Test bottom navigation touchability
      expect(find.text('POS'), findsOneWidget);
      expect(find.text('Jobs'), findsOneWidget);
      
      // Test tapping Jobs tab
      await tester.tap(find.text('Jobs'));
      await tester.pumpAndSettle();

      // Test tapping Customers tab
      await tester.tap(find.text('Customers'));
      await tester.pumpAndSettle();

      // Test tapping Services tab
      await tester.tap(find.text('Services'));
      await tester.pumpAndSettle();

      // Test tapping Outlets tab
      await tester.tap(find.text('Outlets'));
      await tester.pumpAndSettle();

      // Test tapping POS tab to return to start
      await tester.tap(find.text('POS'));
      await tester.pumpAndSettle();
    });

    testWidgets('Test mode badge should be visible', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      // Verify TEST MODE badge is visible
      expect(find.text('TEST MODE'), findsWidgets);
      
      // Navigate to main navigation and check badge is still there
      await tester.tap(find.text('Start Testing'));
      await tester.pumpAndSettle();
      
      expect(find.text('TEST MODE'), findsOneWidget);
    });

    testWidgets('Login button should work from test mode', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      // Find and tap Use Login button
      final useLoginButton = find.text('Use Login');
      expect(useLoginButton, findsOneWidget);
      
      // Verify button is enabled
      final button = tester.widget<ElevatedButton>(find.ancestor(
        of: useLoginButton,
        matching: find.byType(ElevatedButton),
      ));
      expect(button.onPressed, isNotNull, reason: 'Use Login button should be enabled');

      // Test tap on Use Login button
      await tester.tap(useLoginButton);
      await tester.pumpAndSettle();

      // Should navigate to login page (may show login form or different content)
      // This depends on the actual login page implementation
    });
  });
}
