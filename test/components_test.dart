import 'package:fluid_splash/components.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

void main() {
  group('SunAndMoon Widget Tests', () {
    testWidgets('renders with default properties', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(home: Scaffold(body: SunAndMoon(index: 0))),
      );

      expect(find.byType(SunAndMoon), findsOneWidget);
      expect(find.byType(Stack), findsExactly(2));
    });

    testWidgets('renders with custom asset paths', (WidgetTester tester) async {
      final customAssets = [
        'images/Illustration-Blue.png',
        'images/Illustration-Red.png',
        'images/Illustration-Yellow.png',
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: SunAndMoon(index: 1, assetPaths: customAssets)),
        ),
      );

      expect(find.byType(SunAndMoon), findsOneWidget);
    });

    testWidgets('updates animation when drag complete', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: SunAndMoon(index: 0, isDragComplete: false)),
        ),
      );

      // Initial state
      expect(find.byType(AnimatedOpacity), findsNWidgets(3));

      // Update with drag complete
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: SunAndMoon(index: 1, isDragComplete: true)),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.byType(RotationTransition), findsNWidgets(4));
    });

    testWidgets('handles index wrapping correctly', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SunAndMoon(
              index: 5, // Should wrap to 5 % 3 = 2
              isDragComplete: true,
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.byType(SunAndMoon), findsOneWidget);
    });
  });
}
