import 'package:heart_app/height_styles.dart';
import 'package:flutter/material.dart';
import 'package:heart_app/dimensions.dart';

class SliderLabel extends StatelessWidget{
  final int height;

  const SliderLabel({Key key, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: screenAwareSize(4.0, context), bottom: screenAwareSize(2.0, context)),
      child: Text(
        "$height",
        style: TextStyle(
          fontSize: 20.0,
          color: Theme.of(context).primaryColor,
          fontWeight: FontWeight.w600
        ),
      ),
    );
  }

}