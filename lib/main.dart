import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'logo.dart';



void main() {

  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    FirebaseDatabase database;
    database = FirebaseDatabase.instance;
    database.setPersistenceEnabled(true);
    database.setPersistenceCacheSizeBytes(10000000);
    //firebase persistence

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'La touche',
      home: SplashScreen(),
    );
  }
}


/*

@Mohammed_7aafar -> instagram
07711915028
#flutter_Developer

 */