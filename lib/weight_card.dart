import 'package:flutter/material.dart';
import 'package:heart_app/dimensions.dart';
import 'package:heart_app/title_card.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:heart_app/weight_slider.dart';

class WeightCard extends StatefulWidget {

  const WeightCard({Key key, this.onChange}) : super(key: key);

  get initialWeight => null;
  final ValueChanged<int> onChange;


  @override
  State<StatefulWidget> createState() {
    return _WeightCardState();
  }
}

class _WeightCardState extends State<WeightCard> {

  int weight;

  @override
  void initState() {
    super.initState();
    weight = widget.initialWeight ?? 70;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.only(
            top: screenAwareSize(32.0, context),
            left: screenAwareSize(16.0, context),
            right: screenAwareSize(16.0, context)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TitleCard("WEIGHT", subTitle: "(KG)"),
            _drawSlider()
          ],
        ),
      ),
    );
  }

  Widget _drawSlider() {
    return WeightBackground(
        child: LayoutBuilder(
            builder: (context, constraints) => constraints.isTight ? Container() : WeightSlider(
              minValue: 30,
              maxValue: 110,
              width: constraints.maxWidth,
              value: weight,
              onChanged: (val) => widget.onChange(val),
            )));
  }
}

class WeightBackground extends StatelessWidget {
  final Widget child;

  const WeightBackground({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: screenAwareSize(16, context)),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Container(
            height: screenAwareSize(100.0, context),
            decoration: BoxDecoration(
                color: Color.fromRGBO(244, 244, 244, 1.0),
                borderRadius:
                    new BorderRadius.circular(screenAwareSize(50.0, context))),
            child: child,
          ),
          SvgPicture.asset(
            "assets/up_arrow.svg",
            height: screenAwareSize(16.0, context),
            width: screenAwareSize(24.0, context),
            color: Colors.blue,
          ),
        ],
      ),
    );
  }
}
