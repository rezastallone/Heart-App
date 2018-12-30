import 'package:flutter/material.dart';
import 'package:heart_app/dimensions.dart';
import 'package:heart_app/height_slider.dart';
import 'package:heart_app/height_styles.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math' as math;

class HeightPicker extends StatefulWidget{

  final int maxHeight;
  final int minHeight;
  final int height;
  final double widgetHeight;
  final ValueChanged<int> onChange;

  const HeightPicker({Key key, this.maxHeight = 190, this.minHeight = 145, this.height, this.widgetHeight, this.onChange}) : super(key: key);

  int get totalUnits => maxHeight - minHeight;

  @override
  State<StatefulWidget> createState() {
    return _HeightPickerState();
  }
}

class _HeightPickerState extends State<HeightPicker>{

  double startDragYOffset;
  int startDragHeight;

  double get _drawingHeight {
    double totalHeight = widget.widgetHeight;
    double marginBottom = marginBottomAdapted(context);
    double marginTop = marginTopAdapted(context);
    return totalHeight - (marginBottom + marginTop + labelsFontSize);
  }

  double get _pixelsPerUnit{
    return _drawingHeight / widget.totalUnits;
  }

  double get _sliderPosition{
    double halfOfBottomLabel = labelsFontSize / 2;
    int unitsFromBottom = widget.height - widget.minHeight;
    return halfOfBottomLabel + unitsFromBottom * _pixelsPerUnit;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTapDown: _onTapDown,
      onVerticalDragStart: _onDragStart,
      onVerticalDragUpdate: _onDragUpdate,
      child: Stack(
        children: <Widget>[
          _drawPersonImage(),
          _drawLabels(),
          _drawSlider()
        ],
      ),
    );
  }

  Widget _drawSlider(){
    return Positioned(
      child: HeightSlider(height: widget.height),
      left: 0.0,
      right: 0.0,
      bottom: _sliderPosition);
  }

  Widget _drawPersonImage(){
    double personImageHeight = _sliderPosition + marginBottomAdapted(context);
    return Align(
      alignment: Alignment.bottomCenter,
      child: SvgPicture.asset(
        "assets/male_height.svg",
        fit: BoxFit.fitHeight,
        height: personImageHeight,
        width: personImageHeight / 3,
        color: labelsGrey,
      ),
    );
  }

  Widget _drawLabels(){
    int labelsToDisplay = widget.totalUnits ~/ 5 + 1;
    List<Widget> labels = List.generate(labelsToDisplay, (idx){
        return Text(
          "${widget.maxHeight - 5 * idx}",
          style: labelsTextStyle,
        );
    });

    return Align(
      alignment: Alignment.centerRight,
      child: IgnorePointer(
        child: Padding(
          padding: EdgeInsets.only(
            right: screenAwareSize(12.0, context),
            bottom: marginTopAdapted(context),
            top: marginTopAdapted(context),
          ),
          child: Column(
            children: labels,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          ),
        ),
      ),
    );
  }

  void _onTapDown(TapDownDetails details) {
    int height = _globalOffsetToHeight(details.globalPosition);
    widget.onChange(_normalizeHeight(height));
  }

  int _normalizeHeight(int height) {
    return math.max(widget.minHeight, math.min(widget.maxHeight, height));
  }

  int _globalOffsetToHeight(Offset globalPosition) {
    RenderBox getBox = context.findRenderObject();
    Offset localPosition = getBox.globalToLocal(globalPosition);
    double dy = localPosition.dy;
    dy = dy - marginTopAdapted(context) - labelsFontSize / 2;
    int height = widget.maxHeight - ( dy ~/ _pixelsPerUnit);
    return height;
  }

  void _onDragStart(DragStartDetails details) {
    int newHeight = _globalOffsetToHeight(details.globalPosition);
    widget.onChange(newHeight);
    setState(() {
      startDragYOffset = details.globalPosition.dy;
      startDragHeight = newHeight;
    });
  }

  void _onDragUpdate(DragUpdateDetails details) {
    double currentYOffset = details.globalPosition.dy;
    double verticalDifference = startDragYOffset - currentYOffset;
    int diffHeight = verticalDifference ~/ _pixelsPerUnit;
    int height = _normalizeHeight(startDragHeight + diffHeight);
    setState(() {
      widget.onChange(height);
    });
  }
}