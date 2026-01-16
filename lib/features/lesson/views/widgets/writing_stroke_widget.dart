import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// =======================
/// MODEL
/// =======================

class StrokePoint {
  final double x;
  final double y;

  StrokePoint(this.x, this.y);
}

class StrokePath {
  final int id;
  final List<StrokePoint> points;

  StrokePath({required this.id, required this.points});

  factory StrokePath.fromJson(int id, Map<String, dynamic> json) {
    final rawPoints = json['points'] as List;
    return StrokePath(
      id: id,
      points: rawPoints
          .map(
            (p) =>
                StrokePoint((p[0] as num).toDouble(), (p[1] as num).toDouble()),
          )
          .toList(),
    );
  }
}

class WritingStrokeData {
  final String char;
  final List<StrokePath> strokes;

  WritingStrokeData({required this.char, required this.strokes});

  factory WritingStrokeData.fromJson(Map<String, dynamic> json) {
    final strokeList = json['strokes'] as List;
    return WritingStrokeData(
      char: json['char'],
      strokes: List.generate(
        strokeList.length,
        (i) => StrokePath.fromJson(i, strokeList[i]),
      ),
    );
  }
}

/// =======================
/// LOAD JSON
/// =======================

Future<WritingStrokeData> loadAlphabetStroke(
  String assetPath,
  String targetChar,
) async {
  final jsonStr = await rootBundle.loadString(assetPath);
  final jsonMap = jsonDecode(jsonStr);
  final List list = jsonMap['alphabet'];

  final Map<String, dynamic> charData = list.firstWhere(
    (e) => e['char'] == targetChar,
    orElse: () => throw Exception('Character $targetChar not found'),
  );

  return WritingStrokeData.fromJson(charData);
}

/// =======================
/// PAINTER (POINT-BY-POINT)
/// =======================

class StrokePainter extends CustomPainter {
  final List<StrokePath> strokes;
  final int visibleStrokeIndex;
  final int visiblePointCount;

  StrokePainter(this.strokes, this.visibleStrokeIndex, this.visiblePointCount);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black87
      ..strokeWidth = 12
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    const double viewBoxSize = 100;
    const double padding = 40;

    final drawableSize =
        (size.width < size.height ? size.width : size.height) - padding * 2;
    final scale = drawableSize / viewBoxSize;

    final offsetX = (size.width - viewBoxSize * scale) / 2;
    final offsetY = (size.height - viewBoxSize * scale) / 2;

    for (int s = 0; s <= visibleStrokeIndex; s++) {
      final stroke = strokes[s];
      final points = stroke.points;

      final maxPoint = s == visibleStrokeIndex
          ? visiblePointCount
          : points.length;

      if (maxPoint < 2) continue;

      final path = Path();
      path.moveTo(
        points.first.x * scale + offsetX,
        points.first.y * scale + offsetY,
      );

      for (int p = 1; p < maxPoint; p++) {
        path.lineTo(
          points[p].x * scale + offsetX,
          points[p].y * scale + offsetY,
        );
      }

      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant StrokePainter oldDelegate) =>
      oldDelegate.visibleStrokeIndex != visibleStrokeIndex ||
      oldDelegate.visiblePointCount != visiblePointCount;
}

/// =======================
/// WIDGET
/// =======================

class WritingStrokeWidget extends StatefulWidget {
  final String assetPath;
  final String char;

  const WritingStrokeWidget({
    super.key,
    required this.assetPath,
    required this.char,
  });

  @override
  State<WritingStrokeWidget> createState() => _WritingStrokeWidgetState();
}

class _WritingStrokeWidgetState extends State<WritingStrokeWidget> {
  WritingStrokeData? data;

  int currentStroke = 0;
  int currentPoint = 0;
  int _animationToken = 0;

  static const Duration pointDelay = Duration(
    milliseconds: 100,
  ); // ⬅️ SPEED CONTROL

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final value = await loadAlphabetStroke(widget.assetPath, widget.char);
    if (!mounted) return;
    setState(() => data = value);
    _playAnimation();
  }

  Future<void> _playAnimation() async {
    final token = ++_animationToken;

    setState(() {
      currentStroke = 0;
      currentPoint = 0;
    });

    for (int s = 0; s < data!.strokes.length; s++) {
      final points = data!.strokes[s].points;

      for (int p = 1; p <= points.length; p++) {
        await Future.delayed(pointDelay);
        if (!mounted || token != _animationToken) return;

        setState(() {
          currentStroke = s;
          currentPoint = p;
        });
      }

      await Future.delayed(const Duration(milliseconds: 200));
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    if (data == null) {
      return const CircularProgressIndicator();
    }

    return Stack(
      children: [
        Container(
          width: 300,
          height: 300,
          decoration: BoxDecoration(
            color: color.surfaceContainerHigh,
            borderRadius: BorderRadius.circular(12),
          ),
          child: CustomPaint(
            painter: StrokePainter(data!.strokes, currentStroke, currentPoint),
          ),
        ),
        Positioned(
          bottom: 8,
          right: 8,
          child: IconButton(
            onPressed: _playAnimation,
            icon: Icon(Icons.replay_rounded, color: color.primary),
          ),
        ),
      ],
    );
  }
}
