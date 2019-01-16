import 'package:flutter/material.dart';
import 'package:heart_app/dimensions.dart';
import 'package:heart_app/height_picker.dart';
import 'package:heart_app/title_card.dart';

class HeightCard extends StatelessWidget {

  final int height;
  ValueChanged<int> onChanged;

  HeightCard({Key key, this.height, this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.only(top: screenAwareSize(16.0, context)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TitleCard("HEIGHT", subTitle: "(cm)"),
            Expanded(
              child: Padding(
                  padding: EdgeInsets.only(bottom: screenAwareSize(8.0, context)),
                  child: LayoutBuilder(builder: (context, constrains){
                    return HeightPicker(
                      widgetHeight: constrains.maxHeight,
                      height: height,
                      onChange: (val) => onChanged(val),
                    );
                  })),
            )
          ],
        ),
      ),
    );
  }

}
