import 'package:flutter/material.dart';

/// This class is responsible for creating a [gradient Border] around
/// the GlassMorphic Container.
/// You must have to change your [flutter channel] to Dev version if
/// your want to play with it on the web. currently flutter dosen't
/// support custom painter in
///                [Flutter web]                       [Flutter Apps]
///   [master] -- [  Supported   ✔ ]        :        [  Supported   ✔ ]
///    [dev]   -- [  Supported   ✔ ]        :        [  Supported   ✔ ]
///   [beta]   -- [  Supported   ✔ ]        :        [  Supported   ✔ ]
///  [stable]  -- [  Supported   ✔ ]        :        [  Supported   ✔ ]

class GlassmorphicBorder extends StatelessWidget {
  final _GradientPainter _painter;
  final double _radius;
  final width;
  final height;
  GlassmorphicBorder({
    required double strokeWidth,
    required double radius,
    required Gradient gradient,
    this.height,
    this.width,
  })  : this._painter = _GradientPainter(
            strokeWidth: strokeWidth, radius: radius, gradient: gradient),
        this._radius = radius;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _painter,
      size: MediaQuery.of(context).size,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(_radius)),
        ),
        width: width,
        height: height,
      ),
    );
  }
}

/// This class is responsible for creating a [gradient Animated Border] around
/// the GlassMorphic Animated Container.
/// You must have to change your [flutter channel] to Dev version if
/// your want to play with it on the web. currently flutter dosen't
/// support custom painter in
///                [Flutter web]                       [Flutter Apps]
///   [master] -- [  Supported   ✔ ]        :        [  Supported   ✔ ]
///    [dev]   -- [  Supported   ✔ ]        :        [  Supported   ✔ ]
///   [beta]   -- [  Supported   ✔ ]        :        [  Supported   ✔ ]
///  [stable]  -- [  Supported   ✔ ]        :        [  Supported   ✔ ]

class GlassmorphicAnimatedBorder extends StatelessWidget {
  final _GradientPainter _painter;
  final double _radius;
  final width;
  final height;
  final Duration? duration;
  final Curve? curve;

  GlassmorphicAnimatedBorder({
    required double strokeWidth,
    required double radius,
    required Gradient gradient,
    this.height,
    this.width,
    this.duration,
    this.curve,
  })  : this._painter = _GradientPainter(
          strokeWidth: strokeWidth,
          radius: radius,
          gradient: gradient,
        ),
        this._radius = radius;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _painter,
      size: MediaQuery.of(context).size,
      child: AnimatedContainer(
        duration: this.duration ?? Duration(seconds: 1),
        curve: this.curve ?? Curves.linear,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(_radius)),
        ),
        width: width,
        height: height,
      ),
    );
  }
}

class _GradientPainter extends CustomPainter {
  final double radius;
  final double strokeWidth;
  final Gradient gradient;

  _GradientPainter(
      {required double strokeWidth,
      required double radius,
      required Gradient gradient})
      : this.strokeWidth = strokeWidth,
        this.radius = radius,
        this.gradient = gradient;
  final Paint paintObject = Paint();

  @override
  void paint(Canvas canvas, Size size) {
    RRect innerRect2 = RRect.fromRectAndRadius(
        Rect.fromLTRB(strokeWidth, strokeWidth, size.width - (strokeWidth),
            size.height - (strokeWidth)),
        Radius.circular(radius - strokeWidth));

    RRect outerRect = RRect.fromRectAndRadius(
        Rect.fromLTRB(0, 0, size.width, size.height), Radius.circular(radius));
    paintObject.shader = gradient.createShader(Offset.zero & size);

    Path outerRectPath = Path()..addRRect(outerRect);
    Path innerRectPath2 = Path()..addRRect(innerRect2);
    canvas.drawPath(
        Path.combine(PathOperation.difference, outerRectPath, innerRectPath2),
        paintObject);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
