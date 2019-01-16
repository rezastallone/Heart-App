import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'input_page.dart';

void main(){
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
        .then((_) => runApp(new MyApp()));
}

class MyApp extends StatelessWidget{

  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarColor: Colors.white, //top bar color
          statusBarIconBrightness: Brightness.dark, //top bar icons
          systemNavigationBarColor: Colors.white, //bottom bar color
          systemNavigationBarIconBrightness: Brightness.dark, //bottom bar icons
        )
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BMI Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      home: InputPage(),
    );
  }
}

