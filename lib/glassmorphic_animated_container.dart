import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphic_additions.dart';

class GlassmorphicAnimatedContainer extends StatelessWidget {
  /// Creates a widget with Glassmorphic Trend that combines [CustomPainter] class, [ClipRect],[BackdropFilter], and [BlurFilter].
  ///
  ///
  /// The [color] and [decoration] arguments cannot be supplied, since
  /// in glassmorphic container designs [BoxDecoration] is alredy being configured to you
  /// You can easily customize [borderGradient] and [linearGradient] like:
  ///! [Note] If you want to create a container with Dynamic dimentions like `height` , 'width','Size',
  ///! please user use [GlassmorphismFlexContainer]
  ///* [GlassmorphicAnimatedContainer] is only of UIs where you dont use flexibility and responsiveness [Expample link](https://github.com/RitickSaha/glassmorphism/tree/master/example/lib)

  /// ```dart
  /// GlassmorphicAnimatedContainer(
  ///  duration: Duration(seconds: 1,),
  ///  onEnd: () {},
  ///  width: 250,
  ///  height: 250,
  ///  borderRadius: 20,
  ///  blur: 3,
  ///  alignment: Alignment.bottomCenter,
  ///  border: 2,
  ///  linearGradient: LinearGradient(
  ///  begin: Alignment.topLeft,
  ///  end: Alignment.bottomRight,
  ///    colors: [
  ///      const Color(0xFFffffff).withOpacity(0.5),
  ///      const Colors.red.withOpacity(0.2),
  ///    ],
  ///    stops: const [
  ///      0.1,
  ///      1,
  ///    ],
  ///  ),
  ///  borderGradient: LinearGradient(
  ///    begin: Alignment.topLeft,
  ///    end: Alignment.bottomRight,
  ///    colors: [
  ///      const Color(0xFFffffff).withOpacity(0.5),
  ///      const Colors.red.withOpacity(0.5),
  ///    ],
  ///  ),
  ///  child: null
  /// ),
  /// ```

  final Key? key;

  /// Align the [child] within the container.
  ///
  /// If non-null, the container will expand to fill its parent and position its
  /// child within itself according to the given value. If the incoming
  /// constraints are unbounded, then the child will be shrink-wrapped instead.
  ///
  /// Ignored if [child] is null.
  ///
  /// See also:
  ///
  ///  * [Alignment], a class with convenient constants typically used to
  ///    specify an [AlignmentGeometry].
  ///  * [AlignmentDirectional], like [Alignment] for specifying alignments
  ///    relative to text direction.
  final AlignmentGeometry? alignment;

  /// Empty space to inscribe inside the [decoration]. The [child], if any, is
  /// placed inside this padding.
  ///
  /// This padding is in addition to any padding inherent in the [decoration];
  /// see [Decoration.padding].
  final EdgeInsetsGeometry? padding;

  final double width;
  final double height;

  /// Empty space to surround the [decoration] and [child].
  final EdgeInsetsGeometry? margin;

  /// The transformation matrix to apply before painting the container.
  /// it is similar to all the containers
  final Matrix4? transform;

  /// The [child] contained by the container.
  ///
  /// If null, and if the [constraints] are unbounded or also null, the
  /// container will expand to fill all available space in its parent, unless
  /// the parent provides unbounded constraints, in which case the container
  /// will attempt to be as small as possible.
  ///
  /// {@macro flutter.widgets.ProxyWidget.child
  final Widget? child;

  /// All the bellow parametrs are used to design the Glassmorphic effects and this effect is used to
  /// improve the performance ans scalablility as per the requirement.
  /// with good response i will try to [add more featurs and resolve the issues] on my github regarding this package
  /// Thanks for the support... even you can contribute to this project on github.
  final double borderRadius;
  final BoxShape shape;
  final BoxConstraints? constraints;

  final double border;
  final double blur;
  final LinearGradient linearGradient;
  final LinearGradient borderGradient;

  /// All of the parameters below are used for the animation
  final Duration? duration;
  final Curve? curve;
  final VoidCallback? onEnd;

  GlassmorphicAnimatedContainer({
    this.key,
    this.alignment,
    this.padding,
    required this.width,
    required this.height,
    this.margin,
    this.transform,
    this.child,
    required this.borderRadius,
    this.shape = BoxShape.rectangle,
    BoxConstraints? constraints,
    required this.border,
    required this.blur,
    required this.linearGradient,
    required this.borderGradient,
    Duration? duration,
    Curve? curve,
    this.onEnd,
  })  : assert(margin == null || margin.isNonNegative),
        assert(padding == null || padding.isNonNegative),
        assert(constraints == null || constraints.debugAssertIsValid()),
        constraints = constraints?.tighten(width: width, height: height) ??
            BoxConstraints.tightFor(width: width, height: height),
        duration = duration ?? Duration(seconds: 1),
        curve = curve ?? Curves.linear,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: duration!,
      curve: curve!,
      onEnd: onEnd,
      key: key,
      width: width,
      margin: margin,
      alignment: alignment,
      constraints: constraints,
      height: height,
      transform: transform,
      child: Stack(
        alignment: alignment ?? Alignment.topLeft,
        children: [
          ClipRRect(
            clipBehavior: Clip.hardEdge,
            borderRadius: BorderRadius.circular(borderRadius),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur * 2),
              child: Container(
                alignment: alignment ?? Alignment.topLeft,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(borderRadius),
                  gradient: linearGradient,
                ),
              ),
            ),
          ),
          GlassmorphicAnimatedBorder(
            duration: duration,
            curve: curve,
            strokeWidth: border,
            radius: borderRadius,
            width: width,
            height: height,
            gradient: borderGradient,
          ),
          ClipRRect(
            clipBehavior: Clip.hardEdge,
            borderRadius: BorderRadius.circular(borderRadius),
            child: Container(
              child: child,
              alignment: alignment,
            ),
          ),
        ],
      ),
    );
  }
}
