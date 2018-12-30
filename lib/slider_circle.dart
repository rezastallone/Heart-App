import 'package:flutter/material.dart';
import 'package:heart_app/height_styles.dart';

class SliderCircle extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Container(
      width: circleSizeAdapter(context),
      height: circleSizeAdapter(context),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        shape: BoxShape.circle
      ),
      child: Icon(
        Icons.unfold_more,
        color: Colors.white,
        size: 0.6 * circleSizeAdapter(context),
      ),
    );
  }

}