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
      expect(find.text('TEST MODE'), findsOneWidget);
      expect(find.text('MULAI TESTING'), findsOneWidget);
      expect(find.text('GUNAKAN LOGIN'), findsOneWidget);

      // Test that Start Testing button is touchable
      final startTestingButton = find.text('MULAI TESTING');
      expect(startTestingButton, findsOneWidget);
      
      // Verify button is enabled and touchable
      final button = tester.widget<ElevatedButton>(find.ancestor(
        of: startTestingButton,
        matching: find.byType(ElevatedButton),
      ));
      expect(button.onPressed, isNotNull, reason: 'MULAI TESTING button should be enabled');

      // Test tap on Start Testing button
      await tester.tap(startTestingButton);
      await tester.pumpAndSettle();

      // Should navigate to main navigation page
      expect(find.text('Transaksi'), findsOneWidget);
      expect(find.text('Penjualan'), findsOneWidget);
      expect(find.text('Piutang'), findsOneWidget);
      expect(find.text('Mekanik'), findsOneWidget);
    });

    testWidgets('Bottom navigation should be touchable in test mode', (WidgetTester tester) async {
      // Build app and navigate to main navigation
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();
      
      // Tap Start Testing to get to main navigation
      await tester.tap(find.text('MULAI TESTING'));
      await tester.pumpAndSettle();

      // Test bottom navigation touchability
      expect(find.text('Transaksi'), findsOneWidget);
      expect(find.text('Penjualan'), findsOneWidget);
      expect(find.text('Piutang'), findsOneWidget);
      expect(find.text('Mekanik'), findsOneWidget);
      
      // Test tapping Penjualan tab
      await tester.tap(find.text('Penjualan'));
      await tester.pumpAndSettle();

      // Test tapping Piutang tab
      await tester.tap(find.text('Piutang'));
      await tester.pumpAndSettle();

      // Test tapping Mekanik tab
      await tester.tap(find.text('Mekanik'));
      await tester.pumpAndSettle();

      // Test tapping Transaksi tab to return to start
      await tester.tap(find.text('Transaksi'));
      await tester.pumpAndSettle();
    });

    testWidgets('Test mode badge should be visible', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      // Verify TEST MODE badge is visible
      expect(find.text('TEST MODE'), findsWidgets);
      
      // Navigate to main navigation and check badge is still there
      await tester.tap(find.text('MULAI TESTING'));
      await tester.pumpAndSettle();
      
      expect(find.text('TEST MODE'), findsOneWidget);
    });

    testWidgets('Login button should work from test mode', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      // Find and tap Use Login button
      final useLoginButton = find.text('GUNAKAN LOGIN');
      expect(useLoginButton, findsOneWidget);
      
      // Verify button is enabled
      final button = tester.widget<ElevatedButton>(find.ancestor(
        of: useLoginButton,
        matching: find.byType(ElevatedButton),
      ));
      expect(button.onPressed, isNotNull, reason: 'GUNAKAN LOGIN button should be enabled');

      // Test tap on Use Login button
      await tester.tap(useLoginButton);
      await tester.pumpAndSettle();

      // Should navigate to login page (may show login form or different content)
      // This depends on the actual login page implementation
    });

    testWidgets('BLoC providers should be accessible from widget tree', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      // Navigate to main navigation
      await tester.tap(find.text('MULAI TESTING'));
      await tester.pumpAndSettle();

      // The navigation should work without runtime errors, indicating BLoCs are properly provided
      expect(find.text('TRANSAKSI TOKO'), findsOneWidget);
      
      // Test navigation between different tabs that use different BLoCs
      await tester.tap(find.text('Penjualan'));
      await tester.pumpAndSettle();
      // If this doesn't crash, the BLoCs are working

      await tester.tap(find.text('Piutang'));
      await tester.pumpAndSettle();
      // If this doesn't crash, the BLoCs are working

      await tester.tap(find.text('Mekanik'));
      await tester.pumpAndSettle();
      // If this doesn't crash, the ServiceJobBloc is working
    });
  });
}
