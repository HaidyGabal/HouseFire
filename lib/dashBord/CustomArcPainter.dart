import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart';

import 'TColor.dart';

class CustomArcPainter extends CustomPainter {
  final double start;
  final double end;
  final double width;
  final double blurWidth;

  CustomArcPainter({this.start = 0, this.end = 270, this.width = 15, this.blurWidth = 6});

  @override
  void paint(Canvas canvas, Size size) {
    var rect = Rect.fromCircle(
      center: Offset(size.width / 2, size.height / 2),
      radius: size.width / 2,
    );

    var gradientColor = LinearGradient(
      colors: [TColor.primary500,TColor.primary500],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );

    Paint activePaint = Paint()..shader = gradientColor.createShader(rect);
    activePaint.style = PaintingStyle.stroke;
    activePaint.strokeWidth = width;
    activePaint.strokeCap = StrokeCap.round;

    Paint backgroundPaint = Paint();
    backgroundPaint.color = TColor.gray60.withOpacity(0.4);
    backgroundPaint.style = PaintingStyle.stroke;
    backgroundPaint.strokeWidth = width;
    backgroundPaint.strokeCap = StrokeCap.round;



    Paint shadowPaint = Paint()
      ..color = TColor.primary500.withOpacity(0.6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = width + blurWidth
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5);
/////////////////////////////////
    Paint shadowPaint2 = Paint()
      ..color = TColor.secondary.withOpacity(0.4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = width + blurWidth
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5);


    var gradientColor2 = LinearGradient(
      colors: [TColor.secondary,TColor.secondary],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );

    Paint activePaint2 = Paint()..shader = gradientColor2.createShader(rect);
    activePaint2.style = PaintingStyle.stroke;
    activePaint2.strokeWidth = width;
    activePaint2.strokeCap = StrokeCap.round;
/////////////////////


    var startVal = 135.0 + start;

    // Convert end to double explicitly
    var endAngle = end.toDouble();
    endAngle = math.min(endAngle, 1001.0);

    if(endAngle <= 1000){

      canvas.drawArc(rect, radians(startVal), radians(270.0), false, backgroundPaint);

      // Draw Shadow Arc
      Path path = Path();
      path.addArc(rect, radians(startVal), radians(endAngle/3.71));
      canvas.drawPath(path, shadowPaint);

      // Draw active arc
      canvas.drawArc(rect, radians(startVal), radians(endAngle/3.71), false, activePaint);

    }else {
      // Draw background arc
      canvas.drawArc(
          rect, radians(startVal), radians(270.0), false, backgroundPaint);

      // Draw Shadow Arc
      Path path = Path();
      path.addArc(rect, radians(startVal), radians(endAngle / 3.71));
      canvas.drawPath(path, shadowPaint2);

      // Draw active arc
      canvas.drawArc(rect, radians(startVal), radians(endAngle / 3.71), false,activePaint2);
    }
  }

  @override
  bool shouldRepaint(CustomArcPainter oldDelegate) {
    // Implement your logic here to decide if repaint is needed
    return oldDelegate.start != start || oldDelegate.end != end;
  }

  @override
  bool shouldRebuildSemantics(CustomArcPainter oldDelegate) => false;
}
