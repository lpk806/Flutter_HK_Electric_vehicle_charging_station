import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class Dialogs {
  information(BuildContext context,String location,String lat,String lng,String provider,String type,String parkingNo){
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context){
        return AlertDialog(
          title: Text(location),
          content: SingleChildScrollView(
          child:ListBody(
            children: <Widget>[
              Text("提供者: "+provider),
              Text("充電類別:" + type),
              Text("車位號碼: " + parkingNo)
            ],
          )
        ),
        actions: <Widget>[
          FlatButton(
            onPressed: (){
              _goToTheEVStation(lat,lng);
            },
            child: Text("帶我去"),)
        ],
        );
      }
    );
  }

  _goToTheEVStation(String lat, String lng) async {
    String url = 'https://www.google.com/maps/dir/?api=1&destination=' +
        lat +
        ',' +
        lng +
        '&travelmode=driving';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
