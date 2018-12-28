import 'package:flutter/material.dart';

class TitleCard extends StatelessWidget{
  final String title;

  const TitleCard(this.title,{Key key}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    return Text(title,style: new TextStyle(fontSize: 16.0,fontWeight: FontWeight.w500));
  }
}