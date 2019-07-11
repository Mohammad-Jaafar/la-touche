/*

@Mohammed_7aafar -> instagram
07711915028
#flutter_Developer

 */
import 'package:firebase_database/firebase_database.dart';

class Item {
  String _id ;
  String _itemName;
  String _price;
  String _description;
  int _rate;
  String _itemImage;
  String _type;




  String get id => _id;
  String get itemName => _itemName;
  String get price => _price;
  String get description => _description;
  int get rate => _rate;
  String get itemImage => _itemImage;
  String get type => _type;


  Item.fromSnapShot(DataSnapshot snapshot){
    _id = snapshot.key;
    _itemName = snapshot.value['itemName'];
    _price =  snapshot.value['price'];
    _description =  snapshot.value['description'];
    _rate =  snapshot.value['rate'];
    _itemImage =  snapshot.value['itemImage'];
    _type =  snapshot.value['type'];


  }
}


