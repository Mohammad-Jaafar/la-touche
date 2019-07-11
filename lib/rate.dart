/*

@Mohammed_7aafar -> instagram
07711915028
#flutter_Developer

 */
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:firebase_admob/firebase_admob.dart';

import 'menue_db.dart';

// ignore: must_be_immutable
class Rate extends StatefulWidget {

  Rate(this.data);
   Item data;
  @override
  State createState() => new RateState();
}




final itemReference = FirebaseDatabase.instance.reference().child('Items');
class RateState extends State<Rate> {




  var rating=0.0;
  double sum=0.0;
  var t='';



//  @override void initState() {
//    super.initState();
//    myBanner ..load().then((loaded) {
//      if (loaded && this.mounted) {
//        myBanner..show();
//      }
//    });
//  }
//  @override
//  void dispose() {
//    myBanner?.dispose();
//    super.dispose();
//  }

bool isLargeScreen=false;

  @override
  Widget build(BuildContext context) {



//
//    FirebaseAdMob.instance.initialize(appId: "ca-app-pub-7088950138718928~4024570065").then((response){
//
//      myBanner..load()..show();
//      });


    if (MediaQuery.of(context).size.width > 600) {
      isLargeScreen = true;
    } else {
      isLargeScreen = false;
    }
    return isLargeScreen? tablet() : phone();


  }



  Widget phone (){
    Size size = MediaQuery.of(context).size;
    return Scaffold(

        body: new Stack(

            children: <Widget>[

              Center(
                child: new Image.asset(
                  'assets/images/rate.jpg',
                  width: size.width,
                  height: size.height,
                  fit: BoxFit.fill,

                ),
              ),
              Container(
                  child:Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 80,),
                      Align(


                        child: Text('$rating',style: TextStyle(color: Colors.white,fontSize: 60,fontWeight: FontWeight.bold),),
                        alignment: Alignment.center,
                      ),




                      SizedBox(height: 10,),
                      SmoothStarRating(

                        rating: rating,
                        color: Colors.pink[100],
                        allowHalfRating: false,
                        borderColor: Colors.white,
                        size: 40,
                        starCount: 5,
                        onRatingChanged: (value) {
                          setState(() {


                            rating = value;


                            if (widget.data.id != null) {

                              itemReference.child(widget.data.id).update({
                                'rate':value + widget.data.rate,
                                'itemName': widget.data.itemName,
                                'price': widget.data.price,
                                'description': widget.data.description,
                                'itemImage': widget.data.itemImage,
                              });
                            }
                            t ='شكرا لدعمكم';

                          });

                        },
                      ),
                      SizedBox(height: 50,),
                      Text('$t',style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold),),
                      Icon(Icons.tag_faces,color: Colors.pink[100],size: 60,),
                      Container(height:50.0,),

                      InkWell(
                        onTap: () =>  Navigator.of(context).popUntil((route) => route.isFirst),
                        child:Icon(Icons.arrow_back,color: Colors.pink[100],size: 30,),
                      ),

                      InkWell(
                        onTap: () => Navigator.pop(context),
                        child:
                        Text('الرجوع',style: TextStyle(color: Colors.white,fontSize: 20),),
                      ),

                    ],
                  )
              )
            ]
        )

    );
  }


  Widget tablet(){

    Size size = MediaQuery.of(context).size;


    return Scaffold(
        body: new Stack(

            children: <Widget>[

              Center(
                child: new Image.asset(
                  'assets/images/rate.jpg',
                  width: size.width,
                  height: size.height,
                  fit: BoxFit.fill,

                ),
              ),
              Container(
                  child:Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 80,),
                      Align(


                        child: Text('$rating',style: TextStyle(color: Colors.white,fontSize: 60,fontWeight: FontWeight.bold),),
                        alignment: Alignment.center,
                      ),




                      SizedBox(height: 10,),
                      SmoothStarRating(

                        rating: rating,
                        color: Colors.pink[100],
                        allowHalfRating: false,
                        borderColor: Colors.white,
                        size: 40,
                        starCount: 5,
                        onRatingChanged: (value) {
                          setState(() {


                            rating = value;


                            if (widget.data.id != null) {

                              itemReference.child(widget.data.id).update({
                                'rate':value + widget.data.rate,
                                'itemName': widget.data.itemName,
                                'price': widget.data.price,
                                'description': widget.data.description,
                                'itemImage': widget.data.itemImage,
                              });
                            }
                            t ='شكرا لدعمكم';

                          });

                        },
                      ),
                      SizedBox(height: 50,),
                      Text('$t',style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold),),
                      Icon(Icons.tag_faces,color: Colors.pink[100],size: 80,),
                      Container(height:50.0,),

                      InkWell(
                        onTap: () =>  Navigator.of(context).popUntil((route) => route.isFirst),
                        child:Icon(Icons.arrow_back,color: Colors.pink[100],size: 80,),
                      ),

                      InkWell(
                        onTap: () => Navigator.pop(context),
                        child:
                        Text('الرجوع',style: TextStyle(color: Colors.white,fontSize: 80),),
                      ),

                    ],
                  )
              )
            ]
        )

    );


  }
}

//MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
//  keywords: <String>['la touche', 'drinks'],
//  contentUrl: 'https://flutter.io',
//  birthday: DateTime.now(),
//  childDirected: false,
//  designedForFamilies: false,
//  gender: MobileAdGender.male, // or MobileAdGender.female, MobileAdGender.unknown
//  testDevices: <String>["FF8E928FAE27741F494072598A255F82"], // Android emulators are considered test devices
//);
//
//
//BannerAd myBanner = BannerAd(
//  // Replace the testAdUnitId with an ad unit id from the AdMob dash.
//  // https://developers.google.com/admob/android/test-ads
//  // https://developers.google.com/admob/ios/test-ads
//  adUnitId: BannerAd.testAdUnitId,
//  size: AdSize.smartBanner,
//  targetingInfo: targetingInfo,
//  listener: (MobileAdEvent event) {
//    print("BannerAd event is $event");
//  },
//);
//
//
//InterstitialAd myInterstitial = InterstitialAd(
//  // Replace the testAdUnitId with an ad unit id from the AdMob dash.
//  // https://developers.google.com/admob/android/test-ads
//  // https://developers.google.com/admob/ios/test-ads
//  adUnitId: "ca-app-pub-7088950138718928/5841457883",
//  targetingInfo: targetingInfo,
//  listener: (MobileAdEvent event) {
//    print("InterstitialAd event is $event");
//  },
//);