import 'dart:ui';

enum Shape {
  circle,
  line,
  rectangle,
  unknown,
}

class DetectedShape {
  final Shape shape;

  final bool maybeCircle;
  final bool maybeRectangle;
  final bool maybeLine;

  final List<Offset> enclosingRect;
  final List<Offset> convexHull;

  final double rLenPch;
  final double rThinness;
  final double rAltAch;
  final double rPchPer;

  DetectedShape({
    required this.shape,
    required this.maybeCircle,
    required this.maybeRectangle,
    required this.maybeLine,
    required this.enclosingRect,
    required this.convexHull,
    required this.rLenPch,
    required this.rThinness,
    required this.rAltAch,
    required this.rPchPer,
  });
}
