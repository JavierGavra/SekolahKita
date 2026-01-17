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
    (e) => e['char'] == targetChar.toUpperCase(),
    orElse: () => throw Exception('Character $targetChar not found'),
  );

  return WritingStrokeData.fromJson(charData);
}

/// =======================
/// PAINTER
/// =======================

class StrokePainter extends CustomPainter {
  final List<StrokePath> guideStrokes;
  final int visibleStrokeIndex;
  final int visiblePointCount;
  final List<List<Offset>> userStrokes;

  StrokePainter({
    required this.guideStrokes,
    required this.visibleStrokeIndex,
    required this.visiblePointCount,
    required this.userStrokes,
  });

  @override
  void paint(Canvas canvas, Size size) {
    const double viewBoxSize = 100;
    const double padding = 40;

    final drawableSize =
        (size.width < size.height ? size.width : size.height) - padding * 2;
    final scale = drawableSize / viewBoxSize;

    final offsetX = (size.width - viewBoxSize * scale) / 2;
    final offsetY = (size.height - viewBoxSize * scale) / 2;

    /// ===== GUIDE STROKE (ANIMATION) =====
    final guidePaint = Paint()
      ..color = Colors.black26
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    for (int s = 0; s <= visibleStrokeIndex; s++) {
      final stroke = guideStrokes[s];
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

      canvas.drawPath(path, guidePaint);
    }

    /// ===== USER STROKE =====
    final userPaint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 12
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    for (final stroke in userStrokes) {
      if (stroke.length < 2) continue;
      final path = Path()..moveTo(stroke.first.dx, stroke.first.dy);
      for (final p in stroke.skip(1)) {
        path.lineTo(p.dx, p.dy);
      }
      canvas.drawPath(path, userPaint);
    }
  }

  @override
  bool shouldRepaint(covariant StrokePainter oldDelegate) => true;
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

  final List<List<Offset>> userStrokes = [];

  /// ⬅️ Ubah ini untuk speed
  static const Duration pointDelay = Duration(milliseconds: 150);

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final value = await loadAlphabetStroke(widget.assetPath, widget.char);
    if (!mounted) return;
    setState(() => data = value);
    _playGuideAnimation();
  }

  Future<void> _playGuideAnimation() async {
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

      await Future.delayed(const Duration(milliseconds: 150));
    }
  }

  void _reset() {
    userStrokes.clear();
    _playGuideAnimation();
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    if (data == null) {
      return const SizedBox(
        width: 300,
        height: 300,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    return Column(
      children: [
        GestureDetector(
          onPanStart: (d) {
            setState(() {
              userStrokes.add([d.localPosition]);
            });
          },
          onPanUpdate: (d) {
            setState(() {
              userStrokes.last.add(d.localPosition);
            });
          },
          child: Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              color: color.surfaceContainerHigh,
              borderRadius: BorderRadius.circular(16),
            ),
            child: CustomPaint(
              painter: StrokePainter(
                guideStrokes: data!.strokes,
                visibleStrokeIndex: currentStroke,
                visiblePointCount: currentPoint,
                userStrokes: userStrokes,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        IconButton(
          onPressed: _reset,
          icon: Icon(Icons.replay_rounded, color: color.primary),
        ),
      ],
    );
  }
}
