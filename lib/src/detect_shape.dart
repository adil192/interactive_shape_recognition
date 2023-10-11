import 'dart:ui';

import 'package:area_polygon/area_polygon.dart';
import 'package:convex_hull/convex_hull.dart';
import 'package:interactive_shape_recognition/src/shape.dart';
import 'package:interactive_shape_recognition/src/utils.dart';

DetectedShape detectShape(List<Offset> points) {
  final hull = convexHull(
    points,
    x: (Offset p) => p.dx,
    y: (Offset p) => p.dy,
  ).toList(growable: false);

  final hullPerimeter = calcPerimeter(hull); // Pch
  final pointsPerimeter = calcPerimeter(points); // Len

  final hullArea = calculateArea(hull); // Ach
  final hullPerimeterSq = hullPerimeter * hullPerimeter; // Pch^2

  final largestHullTriangle = calcLargestTriangle(hull).area; // Alt

  final enclosingRect = calcEnclosingRect(points);
  final enclosingRectPerimeter = calcPerimeter(enclosingRect); // Per

  final rLenPch = pointsPerimeter / hullPerimeter;
  final rThinness = hullPerimeterSq / hullArea;
  final rAltAch = largestHullTriangle / hullArea;
  final rPchPer = hullPerimeter / enclosingRectPerimeter;

  final maybeCircle =
      rThinness > 11 && rThinness < 14 && (1 - rLenPch).abs() < 0.1;
  final maybeLine = rThinness > 100;
  final maybeRectangle = (1 - rLenPch).abs() < 0.1 && rAltAch > 0.5;

  final shape = maybeCircle
      ? Shape.circle
      : maybeLine
          ? Shape.line
          : maybeRectangle
              ? Shape.rectangle
              : Shape.unknown;

  return DetectedShape(
    shape: shape,
    maybeCircle: maybeCircle,
    maybeRectangle: maybeRectangle,
    maybeLine: maybeLine,
    enclosingRect: enclosingRect,
    convexHull: hull,
    rLenPch: rLenPch,
    rThinness: rThinness,
    rAltAch: rAltAch,
    rPchPer: rPchPer,
  );
}
