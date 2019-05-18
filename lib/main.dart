
import 'package:flutter/material.dart';
import './map.dart';
import 'package:splashscreen/splashscreen.dart';

void main(){
  runApp(new MaterialApp(
    home: new SpashScreenpage(),
  ));
}

class SpashScreenpage extends StatefulWidget{
   @override
  _SpashScreenpageState createState() => new _SpashScreenpageState();
  
}

class _SpashScreenpageState extends State<SpashScreenpage>{
 @override
  Widget build(BuildContext context) {
    return new SplashScreen(
      seconds: 5,
      navigateAfterSeconds: new MyApp(),
      title: new Text('電動車充電站',
      style: new TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 22.0
      ),),
      image: new Image.asset('assets/images/icon.png'),
      backgroundColor: Colors.greenAccent,
      styleTextUnderTheLoader: new TextStyle(),
      photoSize: 100.0,
      onClick: ()=>print("Flutter Egypt"),
      loaderColor: Colors.red
    );
  }
}



