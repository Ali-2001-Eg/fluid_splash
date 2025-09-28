import 'package:fluid_splash/fluid_card.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

void main() {
  group('FluidCard Widget Tests', () {
    testWidgets('renders with required properties', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 300,
              height: 500,
              child: FluidCard(
                color: 'Red',
                subtitle: 'Test subtitle',
                altColor: Colors.blue,
              ),
            ),
          ),
        ),
      );

      expect(find.byType(FluidCard), findsOneWidget);
      expect(find.text('Test subtitle'), findsOneWidget);
    });

    testWidgets('renders with title and subtitle', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 300,
              height: 500,
              child: FluidCard(
                color: 'Blue',
                title: 'Test Title',
                subtitle: 'Test Subtitle',
                altColor: Colors.red,
              ),
            ),
          ),
        ),
      );

      expect(find.text('Test Title'), findsOneWidget);
      expect(find.text('Test Subtitle'), findsOneWidget);
    });

    testWidgets('contains all required images', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 300,
              height: 500,
              child: FluidCard(
                color: 'Yellow',
                subtitle: 'Test',
                altColor: Colors.purple,
              ),
            ),
          ),
        ),
      );

      expect(find.byType(Image), findsNWidgets(3)); // Background and illustration
    });

    testWidgets('has correct styling', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 300,
              height: 500,
              child: FluidCard(
                color: 'Red',
                title: 'Title',
                subtitle: 'Subtitle',
                altColor: Colors.blue,
              ),
            ),
          ),
        ),
      );

      // Check title style
      final titleFinder = find.text('Title');
      final titleWidget = tester.widget<Text>(titleFinder);
      expect(titleWidget.style?.fontSize, 30.0);
      expect(titleWidget.style?.fontFamily, 'MarcellusSC');
      expect(titleWidget.style?.color, Colors.white);

      // Check subtitle style
      final subtitleFinder = find.text('Subtitle');
      final subtitleWidget = tester.widget<Text>(subtitleFinder);
      expect(subtitleWidget.style?.fontSize, 14.0);
      expect(subtitleWidget.style?.fontFamily, 'Lexend');
    });
  });
}