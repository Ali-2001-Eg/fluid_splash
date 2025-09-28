import 'package:fluid_splash/fluid_edge.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

void main() {
  group('FluidEdge Tests', () {
    test('initializes with correct number of points', () {
      final edge = FluidEdge(count: 15);
      expect(edge.points.length, 15);
    });

    test('initializes with default side', () {
      final edge = FluidEdge(count: 10);
      expect(edge.side, Side.left);
    });

    test('initializes with custom side', () {
      final edge = FluidEdge(count: 10, side: Side.right);
      expect(edge.side, Side.right);
    });

    test('resets points correctly', () {
      final edge = FluidEdge(count: 5);
      
      // Modify some points
      edge.points[0].x = 10.0;
      edge.points[1].velX = 5.0;
      
      edge.reset();
      
      for (final point in edge.points) {
        expect(point.x, 0.0);
        expect(point.velX, 0.0);
        expect(point.velY, 0.0);
      }
    });

    test('applies touch offset correctly for left side', () {
      final edge = FluidEdge(count: 10, side: Side.left);
      final offset = Offset(100, 200);
      final size = Size(400, 800);
      
      edge.applyTouchOffset(offset, size);
      
      expect(edge.touchOffset, isNotNull);
      expect(edge.touchOffset!.dx, 100 / 400); // 0.25
      expect(edge.touchOffset!.dy, 200 / 800); // 0.25
    });

    test('applies touch offset correctly for right side', () {
      final edge = FluidEdge(count: 10, side: Side.right);
      final offset = Offset(100, 200);
      final size = Size(400, 800);
      
      edge.applyTouchOffset(offset, size);
      
      expect(edge.touchOffset, isNotNull);
      expect(edge.touchOffset!.dx, 1.0 - (100 / 400)); // 0.75
      expect(edge.touchOffset!.dy, 1.0 - (200 / 800)); // 0.75
    });

    test('clears touch offset when null provided', () {
      final edge = FluidEdge(count: 10);
      edge.applyTouchOffset(Offset(100, 200), Size(400, 800));
      
      expect(edge.touchOffset, isNotNull);
      
      edge.applyTouchOffset();
      
      expect(edge.touchOffset, isNull);
    });

    test('builds path without crashing', () {
      final edge = FluidEdge(count: 10);
      final size = Size(400, 800);
      
      final path = edge.buildPath(size);
      
      expect(path, isNotNull);
      expect(path.getBounds(), isNotNull);
    });

    test('ticks without crashing', () {
      final edge = FluidEdge(count: 10);
      
      // Should not throw
      expect(() => edge.tick(const Duration(milliseconds: 16)), returnsNormally);
    });

    test('notifies listeners on tick', () {
      final edge = FluidEdge(count: 10);
      var notified = false;
      
      edge.addListener(() {
        notified = true;
      });
      
      edge.tick(const Duration(milliseconds: 16));
      
      expect(notified, isTrue);
    });
  });

  group('FluidPoint Tests', () {
    test('creates point with default values', () {
      final point = FluidPoint();
      
      expect(point.x, 0.0);
      expect(point.y, 0.0);
      expect(point.velX, 0.0);
      expect(point.velY, 0.0);
    });

    test('creates point with custom values', () {
      final point = FluidPoint(5.0, 10.0);
      
      expect(point.x, 5.0);
      expect(point.y, 10.0);
    });

    test('converts to offset without transform', () {
      final point = FluidPoint(2.0, 3.0);
      final offset = point.toOffset();
      
      expect(offset.dx, 2.0);
      expect(offset.dy, 3.0);
    });

    test('converts to offset with transform', () {
      final point = FluidPoint(1.0, 1.0);
      final transform = Matrix4.rotationZ(1.0);
      final offset = point.toOffset(transform);
      
      expect(offset, isNotNull);
    });
  });
}