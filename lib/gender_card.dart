import 'package:flutter/material.dart';
import 'package:heart_app/gender.dart';
import 'package:heart_app/dimensions.dart';
import 'package:heart_app/tap_handler.dart';
import 'package:heart_app/title_card.dart';
import 'package:heart_app/gender_icon.dart';
import 'package:heart_app/gender_arrow.dart';

class GenderCard extends StatefulWidget{

  final Gender initialGender;

  const GenderCard({Key key, this.initialGender}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _GenderCardState();
}

class _GenderCardState extends State<GenderCard> with SingleTickerProviderStateMixin{

  Gender selectedGender;

  AnimationController _arrowAnimController;

  @override
  void initState() {
    selectedGender = widget.initialGender ?? Gender.male;
    _arrowAnimController = new AnimationController(
        vsync: this,
        lowerBound: genderAngles[Gender.male],
        upperBound: genderAngles[Gender.female],
        value: genderAngles[selectedGender]);
    super.initState();
  }

  @override
  void dispose() {
    _arrowAnimController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.only(top: screenAwareSize(8.0, context)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              TitleCard("Gender"),
              Padding(
                padding: EdgeInsets.only(top: screenAwareSize(16.0, context)),
                child: _drawMainStack(),
              )
            ],
          ),
        ),
      ),
    );
  }

  _drawGestureDetector() {
    return Positioned.fill(
        child: TapHandler(
      onGenderTapped: _setSelectedGender,
    ));
  }

  Widget _drawCircleIndicator() {
    print("angle ${genderAngles[selectedGender]}");
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        GenderCircle(),
        GenderArrow(listenable: _arrowAnimController,)
      ],
    );
  }

  void _setSelectedGender(Gender gender) {
    setState(() {
      selectedGender = gender;
    });
    _arrowAnimController.animateTo(
      genderAngles[gender],
      duration: Duration(milliseconds: 150)
    );
  }

  Widget _drawMainStack() {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        _drawCircleIndicator(),
        _drawGestureDetector(),
        GenderIconTranslated(gender: Gender.female),
        GenderIconTranslated(gender: Gender.male),
      ],
    );
  }
}

class GenderCircle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: circleSize(context),
      height: circleSize(context),
      decoration: BoxDecoration(
          shape: BoxShape.circle, color: Color.fromRGBO(244, 244, 244, 1.0)),
    );
  }
}
