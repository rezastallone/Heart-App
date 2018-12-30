import 'package:flutter/material.dart';
import 'package:heart_app/dimensions.dart';

double marginBottomAdapted(BuildContext context) => screenAwareSize(marginBottom, context);
double marginTopAdapted(BuildContext context) => screenAwareSize(marginTop, context);
double circleSizeAdapter(BuildContext context) => screenAwareSize(32.0, context);

const TextStyle labelsTextStyle = const TextStyle(
  color: labelsGrey,
  fontSize: labelsFontSize
);

const double marginBottom = 16.0;
const double marginTop = 26.0;
const double labelsFontSize = 13.0;
const Color labelsGrey = const Color.fromRGBO(216, 217, 223, 1.0);