import 'dart:ui';

/// The shape of the detected shape.
enum Shape {
  /// Detected a circle.
  circle,
  /// Detected a line.
  line,
  /// Detected a rectangle.
  rectangle,
  /// Detected an unknown shape.
  unknown,
}

/// The result of the shape detection.
/// 
/// See [shape] for the detected shape, or check
/// [maybeCircle], [maybeRectangle] and [maybeLine]
/// for cases where the shape is not clear.
class DetectedShape {
  DetectedShape({
    required this.shape,

    required this.maybeCircle,
    required this.maybeRectangle,
    required this.maybeLine,

    required this.enclosingRect,
    required this.convexHull,

    required this.firstPoint,
    required this.lastPoint,

    required this.rLenPch,
    required this.rThinness,
    required this.rAltAch,
    required this.rPchPer,
  });

  /// The detected shape.
  final Shape shape;

  /// Whether the shape could be a circle.
  final bool maybeCircle;
  /// Whether the shape could be a rectangle.
  final bool maybeRectangle;
  /// Whether the shape could be a line.
  final bool maybeLine;

  /// The enclosing rectangle of the shape.
  /// 
  /// This is the smallest rectangle that contains
  /// all the points of the shape.
  final List<Offset> enclosingRect;
  /// The convex hull of the shape.
  /// 
  /// This is the smallest convex polygon that contains
  /// all the points of the shape.
  final List<Offset> convexHull;

  /// The first input point.
  final Offset firstPoint;
  /// The last input point.
  final Offset lastPoint;

  /// The ratio between the perimeter of the input vertices
  /// and the perimeter of the convex hull.
  final double rLenPch;
  /// The ratio between the convex hull's
  /// square-perimeter and area.
  final double rThinness;
  /// The ratio between the area of the largest triangle
  /// in the convex hull and the area of the convex hull.
  final double rAltAch;
  /// The ratio between the perimeter of the convex hull
  /// and the perimeter of the enclosing rectangle.
  final double rPchPer;

  /// Returns a rectangle generated from [enclosingRect].
  Rect generateRectangle() {
    return Rect.fromPoints(enclosingRect[0], enclosingRect[2]);
  }
  /// Returns a circle generated from [enclosingRect].
  (double radius, Offset center) generateCircle() {
    final rect = generateRectangle();
    final radius = (rect.width + rect.height) / 4;
    final center = rect.center;
    return (radius, center);
  }
  /// Returns the line between [firstPoint] and [lastPoint].
  (Offset start, Offset end) generateLine() {
    return (firstPoint, lastPoint);
  }
}
