This is a port of [inkandswitch/interactive-shape-recognition](https://github.com/inkandswitch/interactive-shape-recognition), an implementation of "A Simple Approach to Recognise Geometric Shapes Interactively" by Joaquim A. Jorge and Manuel J. Fonseca.

See the
[online demo](https://adil192.github.io/interactive_shape_recognition/)
to see this plugin in action.

## Usage

```dart
final List<Offset> points = [
  // your points here, e.g.
  Offset(0, 0),
  Offset(0, 1),
  Offset(0, 2),
];

final DetectedShape detectedShape = detectShape(points);

switch (detectedShape.shape) {
  case Shape.line:
    print('Detected a line');
    final (Offset startPoint, Offset endPoint) = detectedShape.generateLine();
  case Shape.circle:
    print('Detected a circle');
    final (double radius, Offset center) = detectedShape.generateCircle();
  case Shape.rectangle:
    print('Detected a rectangle');
    final Rect rect = detectedShape.generateRectangle();
  case Shape.unknown:
    print('Detected an unknown shape');
}
```
