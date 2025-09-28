import 'package:fluid_splash/components.dart';
import 'package:fluid_splash/fluid_card.dart';
import 'package:fluid_splash/fluid_carousel.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter/material.dart';
import 'package:fluid_splash/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Fluid App Integration Tests', () {
    testWidgets('app launches successfully', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(FluidCarousel), findsOneWidget);
    });

    testWidgets('displays all three fluid cards', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Verify all three cards are present in the carousel
      expect(find.text('Start Your Day'), findsOneWidget);
      expect(find.text('Refresh Your Mind'), findsOneWidget);
      expect(find.text('Sleep Soundly'), findsOneWidget);
    });

    testWidgets('swipes between cards', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Verify initial card is visible
      expect(find.text('Start Your Day'), findsOneWidget);
      expect(find.text('Refresh Your Mind'), findsNothing);

      // Perform swipe gesture
      await tester.drag(find.byType(FluidCarousel), Offset(-300, 0));
      await tester.pumpAndSettle();

      // Verify next card is visible
      expect(find.text('Start Your Day'), findsNothing);
      expect(find.text('Refresh Your Mind'), findsOneWidget);
    });

    testWidgets('handles multiple swipes', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Swipe multiple times
      for (int i = 0; i < 3; i++) {
        await tester.drag(find.byType(FluidCarousel), Offset(-300, 0));
        await tester.pumpAndSettle(const Duration(milliseconds: 500));
      }

      // Should still be showing one of the cards
      expect(find.byType(FluidCard), findsOneWidget);
    });

    testWidgets('SunAndMoon animation updates on swipe', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Initial state
      expect(find.byType(SunAndMoon), findsOneWidget);

      // Swipe and check animation
      await tester.drag(find.byType(FluidCarousel), Offset(-300, 0));
      await tester.pumpAndSettle();

      expect(find.byType(SunAndMoon), findsOneWidget);
    });

    testWidgets('fluid edge animation works', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Start a drag but don't complete it
      final carouselFinder = find.byType(FluidCarousel);
      await tester.drag(carouselFinder, Offset(-100, 0));
      await tester.pump();

      // Should show partial swipe with fluid effect
      expect(find.byType(ClipPath), findsOneWidget);
    });
  });
}