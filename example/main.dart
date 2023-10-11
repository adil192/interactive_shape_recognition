// ignore_for_file: avoid_print

import 'dart:ui' show Offset;

import 'package:interactive_shape_recognition/interactive_shape_recognition.dart';

void main() {
  const List<Offset> points = [
      // your points here, e.g.
      Offset(0, 0),
      Offset(0, 1),
      Offset(0, 2),
  ];

  final DetectedShape detectedShape = detectShape(points);
  switch (detectedShape.shape) {
    case Shape.line:
      print('Detected a line');
    case Shape.circle:
      print('Detected a circle');
    case Shape.rectangle:
      print('Detected a rectangle');
    case Shape.unknown:
      print('Detected an unknown shape');
  }
}
