import 'dart:math';
import 'dart:ui';

import 'package:area_polygon/area_polygon.dart';

double calcPerimeter(List<Offset> points) {
  double perimeter = 0;
  for (int i = 0; i < points.length - 1; i++) {
    perimeter += (points[i] - points[i + 1]).distance;
  }
  return perimeter;
}

Triangle calcLargestTriangle(List<Offset> points) {
  Triangle largestTriangle = Triangle.zero();

  for (int i = 0; i < points.length; ++i) {
    for (int j = 0; j < points.length; ++j) {
      for (int k = 0; k < points.length; ++k) {
        if (i != j && i != k && k != j) {
          final triangle = Triangle(
            points[i],
            points[j],
            points[k],
          );

          if (triangle.area > largestTriangle.area) {
            largestTriangle = triangle;
          }
        }
      }
    }
  }

  return largestTriangle;
}

List<Offset> calcEnclosingRect(List<Offset> points) {
  final minX = points.map((e) => e.dx).reduce(min);
  final minY = points.map((e) => e.dy).reduce(min);
  final maxX = points.map((e) => e.dx).reduce(max);
  final maxY = points.map((e) => e.dy).reduce(max);

  return [
    Offset(minX, minY),
    Offset(maxX, minY),
    Offset(maxX, maxY),
    Offset(minX, maxY),
  ];
}

class Triangle {
  final Offset a;
  final Offset b;
  final Offset c;

  final double area;

  Triangle(this.a, this.b, this.c) : area = calculateArea([a, b, c]);

  Triangle.zero()
      : a = Offset.zero,
        b = Offset.zero,
        c = Offset.zero,
        area = 0;
}
