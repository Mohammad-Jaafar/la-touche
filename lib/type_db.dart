/*

@Mohammed_7aafar -> instagram
07711915028
#flutter_Developer

 */
import 'package:firebase_database/firebase_database.dart';

class Types{

  String _id ;
  String _typeName;
  String _typeImage;

  String get typeName => _typeName;
  String get id => _id;
  String get typeImage => _typeImage;

  Types.fromSnapShot(DataSnapshot snapshot){
    _id = snapshot.key;
    _typeName =  snapshot.value['typeName'];
    _typeImage = snapshot.value['typeImage'];

  }

}