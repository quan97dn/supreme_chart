// Cores
import 'package:flutter/material.dart';
// Models
import 'package:supreme_chart/src/models/line_chart.dart';

class DrawChart extends CustomPainter {
  final List<LineChart> months;
  final double maxAmplitude;
  final double circularSize;
  final int totalItems;
  final double strokeWidth;
  final double lineWidth;
  final Color lineColor;
  final PaintingStyle paintingStyle;
  final List<Color> colors;

  DrawChart({
    this.months,
    this.maxAmplitude,
    this.circularSize,
    this.totalItems,
    this.strokeWidth,
    this.lineWidth,
    this.lineColor,
    this.paintingStyle,
    this.colors,
  });

  List<Offset> listOffset = [];

  Offset _getPositionLine(Size size, int value, int index) {
    final itemWidth = size.width / totalItems;
    final itemHeight = size.height;
    final height = (itemHeight -
            (value *
                    (itemHeight - strokeWidth - circularSize / 2) /
                    maxAmplitude -
                (circularSize / 2))) -
        circularSize / 2;
    final width = itemWidth / 2 + itemWidth * index;
    return Offset(width, height);
  }

  @override
  void paint(Canvas canvas, Size size) {
    final stepSize = size.width / totalItems / 2;
    final rect = Offset.zero & size;
    final paint = Paint()
      ..style = paintingStyle
      ..strokeWidth = lineWidth;
    if (lineColor != null) {
      paint.color = lineColor;
    }
    if (colors != null) {
      paint
        ..shader = LinearGradient(
          begin: Alignment.center,
          end: Alignment.bottomCenter,
          colors: colors,
        ).createShader(rect);
    }
    final path = Path();

    listOffset.clear();

    months.asMap().forEach((index, element) {
      if (element.value != null) {
        months[index].offset =
            _getPositionLine(size, months[index].value, index);
        listOffset.add(months[index].offset);
      }
    });

    if (listOffset.length > 1) {
      path.moveTo(listOffset[0].dx, listOffset[0].dy);
      for (var i = 0; i < listOffset.length - 1; i++) {
        if (i == 0) {
          path.cubicTo(
            listOffset[0].dx,
            listOffset[0].dy,
            listOffset[0].dx + stepSize,
            listOffset[1].dy,
            listOffset[1].dx,
            listOffset[1].dy,
          );
        } else if (i == listOffset.length - 2) {
          path.cubicTo(
            listOffset[i].dx + stepSize,
            listOffset[i].dy,
            listOffset[i + 1].dx,
            listOffset[i + 1].dy,
            listOffset[i + 1].dx,
            listOffset[i + 1].dy,
          );
        } else {
          path.cubicTo(
            listOffset[i].dx + stepSize,
            listOffset[i].dy,
            listOffset[i].dx + stepSize,
            listOffset[i + 1].dy,
            listOffset[i + 1].dx,
            listOffset[i + 1].dy,
          );
        }
      }
      if (colors != null) {
        path
          ..lineTo(listOffset.last.dx, size.height)
          ..lineTo(listOffset.first.dx, size.height)
          ..lineTo(listOffset.first.dx, listOffset.first.dy)
          ..close();
      }
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }

  @override
  bool shouldRebuildSemantics(CustomPainter oldDelegate) {
    return false;
  }
}
