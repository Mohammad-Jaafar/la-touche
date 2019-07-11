/*

@Mohammed_7aafar -> instagram
07711915028
#flutter_Developer

 */
import 'package:firebase_database/firebase_database.dart';

class Offer {

  String _id ;
  String _offerTitle;
  String _offerDetails;
  String _offerImage;


  String get id => _id;

  String get offerTitle => _offerTitle;
  String get offerDetails => _offerDetails;
  String get offerImage => _offerImage;


  Offer.fromSnapShot(DataSnapshot snapshot){
    _id = snapshot.key;

    _offerTitle =  snapshot.value['offerTitle'];

    _offerDetails =  snapshot.value['offerDetails'];

    _offerImage =  snapshot.value['offerImage'];

  }


}