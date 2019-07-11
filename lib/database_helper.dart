/*

@Mohammed_7aafar -> instagram
07711915028
#flutter_Developer

 */
import 'package:firebase_database/firebase_database.dart';

class ItemToDatabase {

  addNewItem({itemName,context,price,description,rate,itemImage,type}) {
    FirebaseDatabase.instance.reference().child('Items')
        .push().set({
      'itemName':itemName,
      'price' : price,
      'description' : description ,
      'rate' : rate ,
      'itemImage' : itemImage ,
      'type' : type,



    }).catchError((e){
      print('the error is : ${e.toString()}');
    });
  }

  addNewOffer({context,offerTitle,offerDetails,offerImage}) {
    FirebaseDatabase.instance.reference().child('Offers')
        .push().set({

      'offerTitle' : offerTitle ,
      'offerDetails' : offerDetails ,
      'offerImage' : offerImage,



    }).catchError((e){
      print('the error is : ${e.toString()}');
    });
  }


  addNewType({context,typeName,typeImage}) {
    FirebaseDatabase.instance.reference().child('Types')
        .push().set({

      'typeName' : typeName ,
      'typeImage' : typeImage ,




    }).catchError((e){
      print('the error is : ${e.toString()}');
    });
  }




  addNewVideo({context,video}) {
    FirebaseDatabase.instance.reference().child('Videos')
        .push().set({

      'video' : video,

    }).catchError((e){
      print('the error is : ${e.toString()}');
    });
  }





  }
