import 'package:flutter/material.dart';
import 'package:heart_app/dimensions.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:heart_app/gender_icon.dart';
import 'dart:math' as math;

const double _defaultGenderAngle = math.pi / 4;

class GenderArrow extends AnimatedWidget {
  final Listenable listenable;

  const GenderArrow({Key key, this.listenable})
      : super(key: key, listenable: listenable);

  double _arrowLength(BuildContext context) => screenAwareSize(32.0, context);

  double _translateOffset(BuildContext context) => _arrowLength(context) * -0.4;

  @override
  Widget build(BuildContext context) {
    Animation animation = this.listenable;
    return Transform.rotate(
        angle: animation.value,
        child: Transform.translate(
          offset: Offset(0.0, 0.0),
          child: Transform.rotate(
              angle: 0,
              child: SvgPicture.asset('assets/arrow.svg',
                  height: _arrowLength(context), width: _arrowLength(context))),
        ));
  }
}
