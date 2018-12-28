import 'package:flutter/material.dart';
import 'package:heart_app/gender.dart';

class TapHandler extends StatelessWidget{

  final Function(Gender) onGenderTapped;

  const TapHandler({Key key, this.onGenderTapped}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Expanded(flex : 1,child: GestureDetector(onTap: () => onGenderTapped(Gender.male))),
        Expanded(flex : 1,child: GestureDetector(onTap: () => onGenderTapped(Gender.female))),
      ],
    );
  }

}