import 'package:flutter/material.dart';

const double baseHeight = 650.0;

double screenAwareSize(double size, BuildContext context){
  return size * MediaQuery.of(context).size.height / baseHeight;
}

double circleSize(BuildContext context) => screenAwareSize(80.0, context);