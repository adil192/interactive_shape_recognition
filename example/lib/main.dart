import 'dart:async';

import 'package:flutter/material.dart';
import 'package:interactive_shape_recognition/interactive_shape_recognition.dart';
import 'package:interactive_shape_recognition_example/canvas_draw.dart';

final detectedShape = ValueNotifier<DetectedShape?>(null);
Timer? pointDebounce;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Interactive Shape Recognition Demo',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: ValueListenableBuilder(
            valueListenable: detectedShape,
            builder: (context, detectedShape, child) {
              return Text(
                detectedShape == null
                    ? 'Draw below to detect a shape'
                    : 'Detected shape: ${detectedShape.shape}',
              );
            },
          ),
        ),
        body: SizedBox.expand(
          child: CanvasDraw(
            detectedShape: detectedShape,
            onDraw: (points) {
              if (pointDebounce == null || !pointDebounce!.isActive) {
                pointDebounce = Timer(const Duration(milliseconds: 100), () {
                  detectedShape.value = detectShape(points);
                });
              }
            },
          ),
        ),
      ),
    );
  }
}
