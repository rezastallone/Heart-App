import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:heart_app/gender.dart';
import 'package:heart_app/dimensions.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:heart_app/gender_line.dart';

const double _defaultGenderAngle = math.pi / 5.5;

const Map<Gender,double> genderAngles = {
  Gender.female: _defaultGenderAngle,
  Gender.male: -_defaultGenderAngle
};

class GenderIconTranslated extends StatelessWidget{

  static final Map<Gender,String> _genderImages = {
    Gender.male: 'assets/male_gender.svg',
    Gender.female: 'assets/female_gender.svg',
  };

  static final Map<Gender,Color> _genderColors = {
    Gender.male: Colors.indigoAccent,
    Gender.female: Colors.pinkAccent,
  };

  static final Map<Gender,double> _genderIconSize = {
    Gender.male: 20.0,
    Gender.female: 16.0,
  };

  static final Map<Gender,EdgeInsets> _genderPadding = {
    Gender.male: EdgeInsets.only(left: 16.0),
    Gender.female: EdgeInsets.only(right: 0.0),
  };

  final Gender gender;

  const GenderIconTranslated({Key key, this.gender}) : super(key:key);

  String get _assertName => _genderImages[gender];

  Color get _color => _genderColors[gender];

  double get _iconSize => _genderIconSize[gender];

  EdgeInsets get _padding => _genderPadding[gender];

  @override
  Widget build(BuildContext context) {

    Widget icon = Padding(
      padding: _padding,
      child: SvgPicture.asset(_assertName,
      color: _color,
      height: _iconSize, width: _iconSize),
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