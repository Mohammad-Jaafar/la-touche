/*

@Mohammed_7aafar -> instagram
07711915028
#flutter_Developer

 */

import 'dart:async';
import 'package:flutter/material.dart';

import 'package:la_touche/home.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {




  @override
  void initState() {
    super.initState();
    new Timer(new Duration(milliseconds: 2000), () {
      Navigator.of(context).pushReplacement(                 //of => mean with context
          new MaterialPageRoute(builder: (context) => MyHomePage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
              decoration: BoxDecoration(color: Colors.white),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Image.asset(
                            "assets/images/logo.jpg",height: 200.0,width:200.0,),

                        ],
                      ),
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
