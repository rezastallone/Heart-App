import 'package:flutter/material.dart';
import 'package:heart_app/gender_card.dart';
import 'package:heart_app/height_card.dart';
import 'package:heart_app/weight_card.dart';
import 'bmi_app_bar.dart';
import 'dimensions.dart';
import 'gender.dart';
import 'package:heart_app/input_summary_card.dart';

class InputPage extends StatefulWidget{


  @override
  State createState() {
    return new InputPageState();
  }
}

class InputPageState extends State<InputPage>{

  Gender gender = Gender.male;
  int height = 170;
  int weight = 70;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(child: BmiAppBar(), preferredSize: Size.fromHeight(appBarHeight(context))),
      body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        InputSummaryCard(gender: gender, weight: weight, height: height),
        Expanded(child: _buildCards(context)),
        _buildBottom(context),
      ],
    ),
    );
  }

  Widget _buildTitle(BuildContext context){
    return Padding(
      padding: EdgeInsets.only(left: 24.0,top: screenAwareSize(56.0, context)),
      child: Text(
        "BMI Calculator",
        style: new TextStyle(fontSize: 28.0,fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildCards(BuildContext context){
    return Padding(
      padding: EdgeInsets.only(
        left: 14.0,
        right: 14.0
      ),
      child: Row(
        children: <Widget>[
          Expanded(child: Column(
            children: <Widget>[
              Expanded(child: GenderCard(initialGender: gender, onChange: (val) => setState( () => gender = val ))),
              Expanded(child: WeightCard(onChange: (val) => setState( () => weight = val )))
            ],
          )),
          Expanded(child: HeightCard(height: height,onChanged: (val) => setState( () => height = val )))
        ],
      ),
    );
  }

  Widget _tempCard(String label){
    return Card(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        child: Text(label),
      ),
    );
  }

  Widget _buildBottom(BuildContext context){
    return Padding(
      padding: EdgeInsets.only(
        left: screenAwareSize(16.0, context),
        right: screenAwareSize(16.0, context),
        bottom: screenAwareSize(22.0, context),
        top: screenAwareSize(14.0, context)
      ),
      child: Placeholder(
        fallbackHeight: screenAwareSize(52.0, context),
        color: Theme.of(context).primaryColor,
      ),
    );
  }

}