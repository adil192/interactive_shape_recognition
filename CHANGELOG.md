## 1.2.2

- This package has now been replaced with https://pub.dev/packages/one_dollar_unistroke_recognizer

## 1.2.1

- Updated README to mention https://pub.dev/packages/one_dollar_unistroke_recognizer

## 1.2.0

- For performance, `detectShape` will automatically simplify its input points to a length of 500. You can change this by setting `maxPoints` to a different number or null: `detectShape(points, maxPoints: null)`.

## 1.1.1

- pub.dev score optimizations

## 1.1.0

- Added the convenience functions `DetectedShape.generateRectangle`, `DetectedShape.generateCircle`, and `DetectedShape.generateLine` to generate the perfect shape for the given points. You can see this in action in the [online demo](https://adil192.github.io/interactive_shape_recognition/).

## 1.0.1

- pub.dev score optimizations

## 1.0.0

- Port of https://github.com/inkandswitch/interactive-shape-recognition
