/*

@Mohammed_7aafar -> instagram
07711915028
#flutter_Developer

 */
import 'package:firebase_database/firebase_database.dart';

class Video{

  String _id ;
  String _video;

  String get video => _video;
  String get id => _id;

  Video.fromSnapShot(DataSnapshot snapshot){
    _id = snapshot.key;
    _video =  snapshot.value['video'];



  }

}