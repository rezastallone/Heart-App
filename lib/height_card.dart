import 'package:flutter/material.dart';
import 'package:heart_app/dimensions.dart';
import 'package:heart_app/height_picker.dart';
import 'package:heart_app/title_card.dart';

class HeightCard extends StatefulWidget {

  final int height;

  const HeightCard({Key key, this.height}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return HeightCardState();
  }

}

class HeightCardState extends State<HeightCard> {

  int height;

  @override
  void initState() {
    super.initState();
    height = widget.height ?? 170;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.only(top: screenAwareSize(16.0, context)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TitleCard("WEIGHT", subTitle: "(cm)"),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(bottom: screenAwareSize(8.0, context)),
                child: LayoutBuilder(builder: (context, constrains){
                  return HeightPicker(
                    widgetHeight: constrains.maxHeight,
                    height: height,
                    onChange: (val) => setState(() => height = val),
                  );
                })),
            )
          ],
        ),
      ),
    );
  }
}