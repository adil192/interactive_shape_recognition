This is a port of [inkandswitch/interactive-shape-recognition](https://github.com/inkandswitch/interactive-shape-recognition), an implementation of "A Simple Approach to Recognise Geometric Shapes Interactively" by Joaquim A. Jorge and Manuel J. Fonseca.

## Usage

```dart
final List<Offset> points = [
    // your points here, e.g.
    Offset(0, 0),
    Offset(0, 1),
    Offset(0, 2),
];

final DetectedShape detectedShape = detectShape(points);

// detectedShape.shape is one of: Shape.circle, Shape.line, Shape.rectangle, or Shape.unknown
print(detectedShape.shape);
```
