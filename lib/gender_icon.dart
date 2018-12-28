import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:heart_app/gender.dart';
import 'package:heart_app/dimensions.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:heart_app/gender_line.dart';

const double _defaultGenderAngle = math.pi / 4;
const Map<Gender,double> genderAngles = {
  Gender.female: _defaultGenderAngle,
  Gender.male: -_defaultGenderAngle
};

class GenderIconTranslated extends StatelessWidget{

  static final Map<Gender,String> _genderImages = {
    Gender.male: 'assets/male_gender.svg',
    Gender.female: 'assets/female_gender.svg',
  };

  final Gender gender;

  const GenderIconTranslated({Key key, this.gender}) : super(key:key);

  String get _assertName => _genderImages[gender];

  @override
  Widget build(BuildContext context) {

    Widget icon = Padding(
      padding: EdgeInsets.only(left: 0.0),
      child: SvgPicture.asset(_assertName,
      height: 16.0,width: 16.0),
    );

    Widget rotatedIcon = Transform.rotate(angle: -genderAngles[gender],child: icon);

    Widget iconWithLine = Padding(padding: EdgeInsets.only(bottom: circleSize(context)/2),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        rotatedIcon,
        GenderLine(),
      ],
    ),);

    Widget rotatedIconWithALine = Transform.rotate(alignment: Alignment.bottomCenter,
    angle: genderAngles[gender],
    child: iconWithLine,);

    Widget centeredIconWithALine = Padding(
      padding: EdgeInsets.only(bottom: circleSize(context)/2),
      child: rotatedIconWithALine,
    );

    return centeredIconWithALine;
  }
}