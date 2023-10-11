import 'package:flutter/material.dart';
import 'package:interactive_shape_recognition/interactive_shape_recognition.dart';

class CanvasDraw extends StatefulWidget {
  const CanvasDraw({
    super.key,
    required this.detectedShape,
    required this.onDraw,
  });

  final ValueNotifier<DetectedShape?> detectedShape;
  final void Function(List<Offset>) onDraw;

  @override
  State<CanvasDraw> createState() => _CanvasDrawState();
}

class _CanvasDrawState extends State<CanvasDraw> with ChangeNotifier {
  List<Offset> points = [];

  @override
  void initState() {
    super.initState();
    addListener(() {
      widget.onDraw(points);
    });
  }
  @override
  void dispose() {
    removeListener(() {
      widget.onDraw(points);
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: (details) {
        points = [details.localPosition];
        notifyListeners();
      },
      onPanUpdate: (details) {
        points.add(details.localPosition);
        notifyListeners();
      },
      child: CustomPaint(
        painter: _CanvasDrawPainter(this),
      ),
    );
  }
}

class _CanvasDrawPainter extends CustomPainter {
  _CanvasDrawPainter(this.state) : super(repaint: state);

  final _CanvasDrawState state;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;
    for (var i = 0; i < state.points.length - 1; i++) {
      canvas.drawLine(state.points[i], state.points[i + 1], paint);
    }

    final detectedShape = state.widget.detectedShape.value;
    final shapePaint = Paint()
      ..color = Colors.red.withOpacity(0.5)
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    switch (detectedShape?.shape) {
      case null:
      case Shape.unknown:
        break;
      case Shape.circle:
        final (radius, center) = detectedShape!.generateCircle();
        canvas.drawCircle(center, radius, shapePaint);
      case Shape.rectangle:
        final rect = detectedShape!.generateRectangle();
        canvas.drawRect(rect, shapePaint);
      case Shape.line:
        final (start, end) = detectedShape!.generateLine();
        canvas.drawLine(start, end, shapePaint);
    }
  }

  @override
  bool shouldRepaint(covariant _CanvasDrawPainter oldDelegate) {
    return oldDelegate.state.points != state.points;
  }
}
