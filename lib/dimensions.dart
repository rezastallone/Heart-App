import 'package:flutter/material.dart';

const double baseHeight = 650.0;

double screenAwareSize(double size, BuildContext context){
  double drawingHeight =
      MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
  return size * drawingHeight / baseHeight;
}

double circleSize(BuildContext context) => screenAwareSize(80.0, context);

double appBarHeight(BuildContext context){
  return screenAwareSize(80.0, context) + MediaQuery.of(context).padding.top;
}