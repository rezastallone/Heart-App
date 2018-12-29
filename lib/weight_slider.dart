import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:math' as math;

class WeightSlider extends StatelessWidget {
  final int minValue;
  final int maxValue;
  final double width;

  final int value;
  final ValueChanged<int> onChanged;
  final ScrollController scrollController;

  WeightSlider(
      {Key key,
      this.minValue,
      this.maxValue,
      this.width,
      this.value,
      this.onChanged})
      : scrollController = new ScrollController(
            initialScrollOffset: (value - minValue) * width / 3),
        super(key: key);

  double get itemExtent => width / 3;

  int _indexToValue(int index) => minValue + (index - 1);

  @override
  Widget build(BuildContext context) {
    int itemCount = (maxValue - minValue) + 3;
    return NotificationListener(
      onNotification: _onNotification,
      child: new ListView.builder(
        scrollDirection: Axis.horizontal,
        controller: scrollController,
        itemExtent: itemExtent,
        itemCount: itemCount,
        physics: BouncingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          final int value = _indexToValue(index);
          bool isExtra = index == 0 || index == itemCount - 1;

          return isExtra
              ? new Container()
              : GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () => _animateTo(value, durationMillis: 100),
                  child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Center(
                          child: new Text(value.toString(),
                              style: _getTextStyle(value)))),
                );
        },
      ),
    );
  }

  int _offsetToMiddleIndex(double offset) => (offset + width / 2) ~/ itemExtent;

  int _offsetToMiddleValue(double offset) {
    int indexOfMiddleElement = _offsetToMiddleIndex(offset);
    int middleValue = _indexToValue(indexOfMiddleElement);
    return middleValue;
  }

  bool _userStoppedScrolling(Notification notification) {
    return notification is UserScrollNotification &&
        notification.direction == ScrollDirection.idle &&
        scrollController.position.activity is! HoldScrollActivity;
  }

  _animateTo(int valueToSelect, {int durationMillis = 200}) {
    double targetExtent = (valueToSelect - minValue) * itemExtent;
    scrollController.animateTo(targetExtent,
        duration: new Duration(milliseconds: durationMillis),
        curve: Curves.decelerate);
  }

  bool _onNotification(Notification notification) {
    if (notification is ScrollNotification) {
      int middleValue = _offsetToMiddleValue(notification.metrics.pixels);
      middleValue = math.max(minValue, math.min(maxValue, middleValue));
      if (_userStoppedScrolling(notification)) {
        _animateTo(middleValue);
      }

      if (middleValue != value) {
        onChanged(middleValue);
      }
    }
    return true;
  }

  TextStyle _getDefaultTextStyle() {
    return new TextStyle(
        color: Color.fromRGBO(196, 197, 203, 1.0), fontSize: 13.0);
  }

  TextStyle _getHighlightedTextStyle() {
    return new TextStyle(
        color: Color.fromRGBO(77, 123, 243, 1.0), fontSize: 28.0);
  }

  TextStyle _getTextStyle(int itemValue) {
    return itemValue == value
        ? _getHighlightedTextStyle()
        : _getDefaultTextStyle();
  }
}
