/*

@Mohammed_7aafar -> instagram
07711915028
#flutter_Developer

 */

import 'dart:async';
import 'dart:io';

import 'package:date_format/date_format.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:image_picker/image_picker.dart';
import 'package:la_touche/type_db.dart';
import 'package:la_touche/video_helper.dart';
import 'package:la_touche/videos.dart';
import 'package:photo_view/photo_view.dart';
import 'package:video_player/video_player.dart';
import 'database_helper.dart';


import 'package:flutter/services.dart';

import 'home.dart';
import 'menue_db.dart';
import 'offers.dart';


class AddItem extends StatefulWidget {


  @override
  State createState() => new AddItemState();
}

final itemReference = FirebaseDatabase.instance.reference().child('Items');
final offerReference = FirebaseDatabase.instance.reference().child('Offers');
final videoReference = FirebaseDatabase.instance.reference().child('Videos');
final typeReference = FirebaseDatabase.instance.reference().child('Types');

class AddItemState extends State<AddItem> with SingleTickerProviderStateMixin {


  List<Item> itemz;
  List<Offer> offers;
  List<Video> videos;
  List<Types> types;

  TabController _tabController;

  TextEditingController _itemName;
  TextEditingController _price;
  TextEditingController _description;
  TextEditingController _offerDetails;
  TextEditingController _offerTitle;
  TextEditingController _typeName;

  StreamSubscription<Event> _onItemAddedSubscription; // listner for the firebase to update the list ..
  StreamSubscription<Event> _onItemChangedSubscription;

  StreamSubscription<Event> _onOfferAddedSubscription; // listner for the firebase to update the list ..
  StreamSubscription<Event> _onOfferChangedSubscription;
//
  StreamSubscription<Event> _onVideoAddedSubscription; // listner for the firebase to update the list ..
  StreamSubscription<Event> _onVideoChangedSubscription;

  StreamSubscription<Event> _onTypeAddedSubscription; // listner for the firebase to update the list ..
  StreamSubscription<Event> _onTypeChangedSubscription;



  bool _isLoading = true;
  bool _validate = false;
  File video,offerImage,itemImage,typeImage;


pickVideo() async {

  File vid = await ImagePicker.pickVideo(source: ImageSource.gallery);
  if (vid != null) {
    setState(() {
      video = vid;
    });
  }
  }


  pickOfferImage() async {
    File img = await ImagePicker.pickImage(source: ImageSource.gallery);
    // File img2 = await ImagePicker.pickImage(source: ImageSource.camera);
    if (img != null) {
      setState(() {
        offerImage = img;
      });
    }
  }


  pickItemImage() async {
    File img = await ImagePicker.pickImage(source: ImageSource.gallery);
    // File img2 = await ImagePicker.pickImage(source: ImageSource.camera);
    if (img != null) {
      setState(() {
        itemImage = img;
      });
    }
  }

  pickTypeImage() async {
    File img = await ImagePicker.pickImage(source: ImageSource.gallery);
    // File img2 = await ImagePicker.pickImage(source: ImageSource.camera);
    if (img != null) {
      setState(() {
        typeImage = img;
      });
    }
  }


  String url;
  initState() {
    super.initState();

    itemz = new List();
    offers = new List();
    videos = new List();
    types = new List();

    _onItemAddedSubscription = itemReference.onChildAdded.listen(_onItemAdded);
    _onItemChangedSubscription = itemReference.onChildChanged.listen(_onItemUpdated);

    _onOfferAddedSubscription = offerReference.onChildAdded.listen(_onOfferAdded);
    _onOfferChangedSubscription = offerReference.onChildChanged.listen(_onOfferUpdated);
//
    _onVideoAddedSubscription = videoReference.onChildAdded.listen(_onVideoAdded);
    _onVideoChangedSubscription = videoReference.onChildChanged.listen(_onVideoUpdated);


    _onTypeAddedSubscription = typeReference.onChildAdded.listen(_onTypeAdded);
    _onTypeChangedSubscription = typeReference.onChildChanged.listen(_onTypeUpdated);

    _itemName = new TextEditingController();
    _price = new TextEditingController();
    _description = new TextEditingController();
    _offerDetails = new TextEditingController();
    _offerTitle = new TextEditingController();
    _typeName = new TextEditingController();

    _tabController = new TabController(length: 8, vsync: this);

    url = "";


  }
  @override
  void dispose() {  /// close database .....

    super.dispose();
    _onItemAddedSubscription.cancel();
    _onItemChangedSubscription.cancel();

    _onOfferAddedSubscription.cancel();
    _onOfferChangedSubscription.cancel();
//
    _onVideoAddedSubscription.cancel();
    _onVideoChangedSubscription.cancel();

    _onTypeAddedSubscription.cancel();
    _onTypeChangedSubscription.cancel();

  }



  String type;



  @override
  Widget build(BuildContext context) {

    var fullImagePath;

    var now = formatDate(new DateTime.now(), [yyyy, '-', mm, '-', dd, ' ', HH, ':', nn]);
    var fullOfferImageName = 'images/${_offerTitle.text}-$now' + '.jpg';
    var fullItemImageName = 'images/${_itemName.text}-$now' + '.png';
    var fullTypeImageName = 'images/${_typeName.text}-$now' + '.png';
    var fullVideoName = 'videos/-$now' + '.mp4';
    Size size = MediaQuery.of(context).size;

    return new Scaffold(

        resizeToAvoidBottomPadding: false,
         resizeToAvoidBottomInset: false,


        backgroundColor: Colors.white,

     appBar: AppBar(
       backgroundColor: Colors.black,
       iconTheme: IconThemeData(
         color: Colors.pink[100], //change your color here
       ),
      bottom: TabBar(
        unselectedLabelColor: Colors.white,
        labelColor: Colors.pink[100],
        tabs: [
          new Tab(icon: Icon(FontAwesomeIcons.cocktail)),
          new Tab(
            icon: new Icon(FontAwesomeIcons.percentage),
          ),
          new Tab(
            icon: new Icon(FontAwesomeIcons.iceCream),
          ),

          new Tab(
            icon: new Icon(FontAwesomeIcons.star),
          ),

          new Tab(
            icon: new Icon(FontAwesomeIcons.edit),
          ),

          new Tab(
            icon: new Icon(FontAwesomeIcons.edit),
          ),

          new Tab(
            icon: new Icon(FontAwesomeIcons.edit),
          ),

          new Tab(
            icon: new Icon(FontAwesomeIcons.edit),
          ),




        ],
        controller: _tabController,
        indicatorColor: Colors.white,
        indicatorSize: TabBarIndicatorSize.tab,),
      bottomOpacity: 1,
    ),

        body: TabBarView(children :

            [
          new SingleChildScrollView(
          scrollDirection: Axis.vertical,
          reverse: true,
            child:   new Stack(

                    children: <Widget>[


                      Center(
                        child: new Image.asset(
                          'assets/images/menue.jpg',
                          width: size.width,
                          height: size.height,
                          fit: BoxFit.fill,

                        ),
                      ),

                      new Container(
                          child : Column(
                              mainAxisAlignment: MainAxisAlignment.center,

                              children: <Widget>[
                                SizedBox(height: 200,),
                                new TextFormField(

                                  decoration: new InputDecoration(

                                    errorText: _validate ? 'الحقل لا يمكن ان يكون خالي ' : null,
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.white),
                                    ),
                                    labelText: "اسم العنصر",
                                    labelStyle: TextStyle(color: Colors.white),
                                    fillColor: Colors.pink[400],

                                    icon: Icon(FontAwesomeIcons.iceCream, color: Colors.white,),
                                    focusedBorder:OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.white, width: 0.0),
                                    ),
                                  ),
                                  style: TextStyle(color: Colors.pink[100]),
                                  controller: _itemName,
                                  cursorColor: Colors.pink[100],
                                  keyboardType: TextInputType.text,
                                ),

                                SizedBox(height: 10,),


                                new TextFormField(

                                  decoration: new InputDecoration(

                                    errorText: _validate ? 'الحقل لا يمكن ان يكون خالي ' : null,
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.white),
                                    ),
                                    labelText: "السعر",
                                    labelStyle: TextStyle(color: Colors.white),
                                    fillColor: Colors.pink[400],

                                    icon: Icon(FontAwesomeIcons.moneyCheckAlt, color: Colors.white,),
                                    focusedBorder:OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.white, width: 0.0),
                                    ),
                                  ),
                                  style: TextStyle(color: Colors.pink[100]),
                                  controller: _price,
                                  cursorColor: Colors.pink[100],
                                  keyboardType: TextInputType.text,
                                ),

                                SizedBox(height: 10,),

                                new TextFormField(

                                  decoration: new InputDecoration(

                                    errorText: _validate ? 'الحقل لا يمكن ان يكون خالي ' : null,
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.white),
                                    ),
                                    labelText: "وصف العنصر",
                                    labelStyle: TextStyle(color: Colors.white),
                                    fillColor: Colors.pink[400],

                                    icon: Icon(FontAwesomeIcons.cocktail, color: Colors.white,),
                                    focusedBorder:OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.white, width: 0.0),
                                    ),
                                  ),
                                  style: TextStyle(color: Colors.pink[100]),
                                  controller: _description,
                                  cursorColor: Colors.pink[100],

                                  keyboardType: TextInputType.text,
                                ),

                                new DropdownButton(

                                  icon: Icon(Icons.arrow_drop_down,color: Colors.white,),
                                  isExpanded: true,
                                  style: TextStyle(color: Colors.pink[100]),

                                  hint: Text('اختر النوع',style: TextStyle(color: Colors.pink[100],),), // Not necessary for Option 1
                                  value: type,
                                  onChanged: (newValue) {
                                    setState(() {
                                      type = newValue;
                                    });
                                  },
                                  items: types.map((location) {
                                    return DropdownMenuItem(
                                      child: new Text(location.typeName),
                                      value: location.typeName,
                                    );
                                  }).toList(),
                                ),

                                SizedBox(height: 10,),

                                        Column(
                                          children: <Widget>[

                                            InkWell(
                                              onTap: pickItemImage,
                                              child:Icon(Icons.add_a_photo,
                                                color: Colors.white,size: 35,),),
                                            SizedBox(height: 20,),
                                            itemImage == null
                                                ? Text('اختر صوره العنصر',
                                              style: TextStyle(color: Colors.pink[100]),)
                                                : Text('تم اختيار الصورة',
                                              style: TextStyle(color: Colors.pink[100]),),

                                          ],),

                                ]

                          ) ),

                      Container(height: 30.0,),
                    ],
                  )),

        new SingleChildScrollView(
          scrollDirection: Axis.vertical,
          reverse: true,
          child:
          new Stack(

                    children: <Widget>[


                      Center(
                        child: new Image.asset(
                          'assets/images/menue.jpg',
                          width: size.width,
                          height: size.height,
                          fit: BoxFit.fill,

                        ),
                      ),

                      new Container(
                          child : Column(
                              mainAxisAlignment: MainAxisAlignment.center,

                              children: <Widget>[
                                SizedBox(height: 200,),




                                new TextFormField(

                                  decoration: new InputDecoration(

                                    errorText: _validate ? 'الحقل لا يمكن ان يكون خالي ' : null,
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.white),
                                    ),
                                    labelText: "عنوان العرض",
                                    labelStyle: TextStyle(color: Colors.white),
                                    fillColor: Colors.pink[400],

                                    icon: Icon(FontAwesomeIcons.percentage, color: Colors.white,),
                                    focusedBorder:OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.white, width: 0.0),
                                    ),
                                  ),
                                  style: TextStyle(color: Colors.pink[100]),
                                  controller: _offerTitle,
                                  cursorColor: Colors.pink[100],
                                  keyboardType: TextInputType.text,
                                ),

                                SizedBox(height: 10,),

                                new TextFormField(

                                  decoration: new InputDecoration(

                                    errorText: _validate ? 'الحقل لا يمكن ان يكون خالي ' : null,
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.white),
                                    ),
                                    labelText: "وصف العرض",
                                    labelStyle: TextStyle(color: Colors.white),
                                    fillColor: Colors.pink[400],

                                    icon: Icon(FontAwesomeIcons.receipt, color: Colors.white,),
                                    focusedBorder:OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.white, width: 0.0),
                                    ),
                                  ),
                                  cursorColor: Colors.pink[100],
                                  maxLength: 40,
                                  style: TextStyle(color: Colors.pink[100]),
                                  controller: _offerDetails,

                                  keyboardType: TextInputType.text,
                                ),

                                SizedBox(height: 50,),


                                        Column(
                                          children: <Widget>[

                                            InkWell(
                                              onTap: pickOfferImage,
                                              child:Icon(Icons.photo_library,
                                                color: Colors.white,size: 35,),),
                                            SizedBox(height: 20,),
                                            offerImage == null
                                                ? Text('اختر صوره العرض',
                                              style: TextStyle(color: Colors.pink[100]),)
                                                : Text('تم اختيار الصورة',
                                              style: TextStyle(color: Colors.pink[100]),),

                                          ],),
                              ]
                          ) ),
                      Container(height: 30.0,),
                    ],
                  ),
        ),



               new Stack(
                    children: <Widget>[
                      Center(
                        child: new Image.asset(
                          'assets/images/menue.jpg',
                          width: size.width,
                          height: size.height,
                          fit: BoxFit.fill,

                        ),
                      ),

                      new Container(
                          child : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                      Align(
                                        alignment: Alignment.center,
                                        child:Column(
                                          children: <Widget>[

                                            InkWell(
                                              onTap: pickVideo,
                                              child:Icon(Icons.video_call,
                                                color: Colors.white,size: 35,),),
                                            SizedBox(height: 20,),
                                            video == null
                                                ? Text('اختر فيديو',
                                              style: TextStyle(color: Colors.pink[100]),)
                                                : Text('تم اختيار الفيديو',
                                              style: TextStyle(color: Colors.pink[100]),),
                                          ],),
                                      ),


                              ]

                          ) ),

                      Container(height: 30.0,),
                    ],
                  ),



          new SingleChildScrollView(

            scrollDirection: Axis.vertical,
            reverse: true,
            child:
            new Stack(

              children: <Widget>[


                Center(
                  child: new Image.asset(
                    'assets/images/menue.jpg',
                    width: size.width,
                    height: size.height,
                    fit: BoxFit.fill,

                  ),
                ),

                new Container(
                    child : Column(
                        mainAxisAlignment: MainAxisAlignment.center,

                        children: <Widget>[
                          SizedBox(height: 200,),




                          new TextFormField(

                            decoration: new InputDecoration(

                              errorText: _validate ? 'الحقل لا يمكن ان يكون خالي ' : null,
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              labelText: "اسم النوع",
                              labelStyle: TextStyle(color: Colors.white),
                              fillColor: Colors.pink[400],

                              icon: Icon(FontAwesomeIcons.percentage, color: Colors.white,),
                              focusedBorder:OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white, width: 0.0),
                              ),
                            ),
                            style: TextStyle(color: Colors.pink[100]),
                            controller: _typeName,
                            cursorColor: Colors.pink[100],
                            keyboardType: TextInputType.text,
                          ),

                          SizedBox(height: 50,),

                          Column(
                            children: <Widget>[

                              InkWell(
                                onTap: pickTypeImage,
                                child:Icon(Icons.add_circle,
                                  color: Colors.white,size: 35,),),
                              SizedBox(height: 20,),
                              typeImage == null
                                  ? Text('اختر صوره النوع',
                                style: TextStyle(color: Colors.pink[100]),)
                                  : Text('تم اختيار الصورة',
                                style: TextStyle(color: Colors.pink[100]),),

                            ],),
                        ]
                    ) ),
                Container(height: 30.0,),
              ],
            ),
          ),


              ///////////////////////////////////////////////////////////////

          Container(
            child: new Stack(
              children: <Widget>[
                new Padding(
                  padding: new EdgeInsets.only(top: 5.0),
                  child:

                  new Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      new Align(
                        alignment: Alignment.centerLeft,
                        child: new Padding(
                            padding: new EdgeInsets.only(left: 8.0),
                            child: new Text(
                              'عروض خاصة',
                              style: new TextStyle(color: Colors.white),
                            )),
                      ),
//                  new Container(
//                      height: 200.0, width: _width, child: headerList,
//                  ),

                      new Expanded(child:
                      ListView.builder(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return new ListTile(
                              subtitle: Container(
                                  width: 200.0,
                                  child:
                                  Container(
                                    child: Column(
                                      children: <Widget>[

                                        Text(
                                          '${itemz[index].description}',
                                          style: TextStyle(
                                              color: Colors.grey,fontSize: 20),
                                        ),
                                        SizedBox(height: 50,),
                                      ],
                                    ),
                                  )


                              ),
                              title: new Column(
                                children: <Widget>[
                                  new Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      new Container(
                                        height: 150.0,
                                        width: 100.0,
                                        decoration: new BoxDecoration(
                                            color: Colors.transparent,
                                            boxShadow: [
                                              new BoxShadow(
                                                  color:
                                                  Colors.black.withAlpha(70),
                                                  offset: const Offset(2.0, 2.0),
                                                  blurRadius: 2.0)
                                            ],
                                            borderRadius: new BorderRadius.all(
                                                new Radius.circular(12.0)),

                                            image: new DecorationImage(


                                              image: NetworkImage(
                                                '${itemz[index].itemImage}',

                                              ),
                                              fit: BoxFit.cover,
                                            )),

                                      ),
                                      new SizedBox(
                                        width: 20.0,
                                      ),


                                      new Container(
                                          child: Column(
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .start,
                                              children: <Widget>[
                                                Container(
                                                  decoration: BoxDecoration(
                                                      color: Colors.pink[100],
                                                      borderRadius: BorderRadius
                                                          .circular(4.0)),
                                                  child: Padding(
                                                    padding: const EdgeInsets.symmetric(
                                                        horizontal: 8.0, vertical: 4.0),
                                                    child: Row(
                                                      children: <Widget>[
                                                        Icon(
                                                          Icons.star,
                                                          size: 15.0,
                                                        ),

                                                        Text('${itemz[index].rate}'),

                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 8.0,
                                                ),



                                                Container(
                                                  decoration: BoxDecoration(
                                                      color: Colors.pink[100],
                                                      borderRadius: BorderRadius
                                                          .circular(4.0)),
                                                  child: Padding(
                                                    padding: const EdgeInsets.symmetric(
                                                        horizontal: 8.0, vertical: 4.0),
                                                    child: Row(
                                                      children: <Widget>[
                                                        Text('دينار'

                                                        ),
                                                        Text('${itemz[index].price}')
                                                      ],
                                                    ),
                                                  ),
                                                ),

                                                SizedBox(
                                                  height: 8.0,
                                                ),
                                                Text(
                                                  '${itemz[index].itemName}',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 20,
                                                  ),
                                                ),



                                              ])),



                                    ],
                                  ),
                                  new Divider(),
                                ],
                              ),

                              trailing: IconButton(
                                  icon: Icon(Icons.delete,color: Colors.pink,size: 40,)
                                  , onPressed: () => _deleteItem(context, itemz[index],index)
                              ),


                          );
                        }, itemCount: itemz.length,)),



                    ],
                  ),

                ),
              ],
            ),
          ),


      StaggeredGridView.countBuilder(
        crossAxisCount: 4,
        itemCount: offers.length,
        itemBuilder: (BuildContext context, int index) {

          EdgeInsets padding = index == 0
              ? const EdgeInsets.only(
              left: 20.0, right: 10.0, top: 4.0, bottom: 30.0)
              : const EdgeInsets.only(
              left: 10.0, right: 10.0, top: 4.0, bottom: 30.0);

          return Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                offers[index].offerImage != null

                    ? GestureDetector(
                    onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return  PhotoView(
                        imageProvider: NetworkImage("${offers[index].offerImage}"),
                      );
                    })),
                    child: Image.network("${offers[index].offerImage}")
                )
                    : Text('error'),


                Align(
                    alignment: Alignment.center,
                    child:Text('${offers[index].offerDetails}',style: TextStyle(color:Colors.pink,fontWeight: FontWeight.bold,fontSize: 20),
                    )),

                IconButton(
                    icon: Icon(Icons.delete,color: Colors.pink,size: 40,)
                    , onPressed: () => _deleteOffer(context, offers[index],index)
                ),

              ],
            ),
          );

        },
        staggeredTileBuilder: (int index) => StaggeredTile.fit(2),
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
      ),


   Scaffold(
    body:
    new Container(child: ListView.builder(
    shrinkWrap: true,
    itemBuilder: (context, index) {

//
//                               _controller = VideoPlayerController.network(
//                                   "${videos[index].video}");


      EdgeInsets padding = index == 0
          ? const EdgeInsets.only(
          left: 20.0, right: 10.0, top: 4.0, bottom: 30.0)
          : const EdgeInsets.only(
          left: 10.0, right: 10.0, top: 4.0, bottom: 30.0);

      return new Padding(
        padding: padding,
        child: new InkWell(
          onTap: () {
            print('Card selected');
          },
          child:
          Container(
            child: Column(
              children: <Widget>[

                ChewieListItem(
                  videoPlayerController: VideoPlayerController.network(
                    '${videos[index].video}',
                  ),
                  looping: false,

                ),
                IconButton(
                    icon: Icon(Icons.delete,color: Colors.pink,size: 40,)
                    , onPressed: () => _deleteVideo(context, videos[index],index)
                ),

              ],
            ),
          ),
        ),
      );
    },
    scrollDirection: Axis.vertical,
    itemCount: videos.length,
    )),


    ),

      StaggeredGridView.countBuilder(
        crossAxisCount: 4,
        itemCount: types.length,
        itemBuilder: (BuildContext context, int index) {

          EdgeInsets padding = index == 0
              ? const EdgeInsets.only(
              left: 20.0, right: 10.0, top: 4.0, bottom: 30.0)
              : const EdgeInsets.only(
              left: 10.0, right: 10.0, top: 4.0, bottom: 30.0);

          return Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                types[index].typeImage != null
                    ? GestureDetector(
                    onTap:  (){},


                    child: Image.network("${types[index].typeImage}")
                )
                    : Text('error'),
                Align(
                    alignment: Alignment.center,
                    child:Text('${types[index].typeName}',style: TextStyle(color:Colors.black,fontWeight: FontWeight.bold,fontSize: 20),
                    )),

                IconButton(
                    icon: Icon(Icons.delete,color: Colors.pink,size: 40,)
                    , onPressed: () => _deleteType(context, types[index],index)
                ),
                SizedBox(height: 30,),
              ],
            ),
          );
        },
        staggeredTileBuilder: (int index) => StaggeredTile.fit(2),
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
      ),





        ],



          controller: _tabController,
        ),


        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(


          child: _isLoading ?
          Icon(FontAwesomeIcons.signInAlt, color: Colors.black,) :
          SizedBox(child:CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Colors.black),),width: 25.0,height: 25.0,),
          onPressed: () {

            setState(() {
              if (!mounted) return;
              _isLoading = false;
            });

            if(video != null) {
              uploadVideo(fullVideoName, context).then((path) {

             //   var videoSource = ExtractorMediaSource.Factory(factory).createMediaSource(Uri.parse("assets:///onboarding_video.mp4"));

                fullImagePath = path;

                ItemToDatabase().addNewVideo(
                  video: '$fullImagePath', context: context,

                );
                Navigator.of(context).popUntil((route) => route.isFirst);
              }).catchError((e) {
                print(e.toString());
              });
            }

            if(offerImage != null) {
              uploadOfferImage(fullOfferImageName, context).then((path) {
                fullImagePath = path;

                ItemToDatabase().addNewOffer(
                     context: context,
                    offerImage: '$fullImagePath',
                  offerTitle: _offerTitle.text,
                  offerDetails: _offerDetails.text,
                );
                Navigator.of(context).popUntil((route) => route.isFirst);
              }).catchError((e) {
                print(e.toString());
              });
            }

            if(itemImage != null) {
              uploadItemImage(fullItemImageName, context).then((path) {
                fullImagePath = path;
             int x=0;
                ItemToDatabase().addNewItem(
                    itemName: _itemName.text, context: context,
                    itemImage: '$fullImagePath',
                    price: _price.text,
                  description: _description.text,
                  rate: x,
                  type: type,

                );
                Navigator.of(context).popUntil((route) => route.isFirst);
              }).catchError((e) {
                print(e.toString());
              });
            }

            if(typeImage != null) {
              uploadTypeImage(fullTypeImageName, context).then((path) {
                fullImagePath = path;

                ItemToDatabase().addNewType(
                  context: context,
                  typeImage: '$fullImagePath',
                  typeName: _typeName.text,

                );
                Navigator.of(context).popUntil((route) => route.isFirst);
              }).catchError((e) {
                print(e.toString());
              });
            }






          },
          tooltip: 'تسجيل',
          backgroundColor: Colors.pink[100],
          elevation: 2.0,
        ),

        bottomNavigationBar: new Theme(

          data: Theme.of(context).copyWith(
            // sets the background color of the `BottomNavigationBar`
              canvasColor: Colors.black),
          child: new BottomNavigationBar (

            items: <BottomNavigationBarItem>[
              new BottomNavigationBarItem(
                icon: Icon(Icons.arrow_drop_down, color: Colors.black,),
                title: Text(
                  '', style: TextStyle(color: Colors.black,),),
              ),
              new BottomNavigationBarItem(
                icon: Icon(Icons.arrow_drop_down, color: Colors.black,),
                title: Text(
                  '', style: TextStyle(color: Colors.blueGrey[700],),),
              ),

            ],
            onTap: null,
          ),
        )
    );
  }

//

  Future<String> uploadVideo(videoName,context ) async {

    StorageReference ref = FirebaseStorage.instance.ref().child(videoName);
    StorageUploadTask uploadTask = ref.putFile(video);

    var dowurl = await (await uploadTask.onComplete).ref.getDownloadURL();
    url = dowurl.toString();

    debugPrint(url);
    return url;
  }

  Future<String> uploadOfferImage(fullImageName,context ) async {

    StorageReference ref = FirebaseStorage.instance.ref().child(fullImageName);
    StorageUploadTask uploadTask = ref.putFile(offerImage);

    var dowurl = await (await uploadTask.onComplete).ref.getDownloadURL();
    url = dowurl.toString();

    debugPrint(url);
    return url;
  }

  Future<String> uploadItemImage(fullImageName,context ) async {

    StorageReference ref = FirebaseStorage.instance.ref().child(fullImageName);
    StorageUploadTask uploadTask = ref.putFile(itemImage);

    var dowurl = await (await uploadTask.onComplete).ref.getDownloadURL();
    url = dowurl.toString();

    debugPrint(url);
    return url;
  }

  Future<String> uploadTypeImage(fullImageName,context ) async {

    StorageReference ref = FirebaseStorage.instance.ref().child(fullImageName);
    StorageUploadTask uploadTask = ref.putFile(typeImage);

    var dowurl = await (await uploadTask.onComplete).ref.getDownloadURL();
    url = dowurl.toString();

    debugPrint(url);
    return url;
  }

  void _onItemAdded(Event event){
    setState((){
      itemz.add(new Item.fromSnapShot(event.snapshot));
    });
  }

  void _onItemUpdated(Event event){
    var oldItemValue = itemz.singleWhere((item) => item.id == event.snapshot.key);
    setState((){
      itemz[itemz.indexOf(oldItemValue)] = new Item.fromSnapShot(event.snapshot);
    });
  }

  void _deleteItem(BuildContext context, Item item,int position)async{
    await itemReference.child(item.id).remove().then((_){// then means server responds nothing (_)
      setState(() {
        itemz.removeAt(position);
      });
    });
  }

  void _onOfferAdded(Event event){
    setState((){
      offers.add(new Offer.fromSnapShot(event.snapshot));
    });
  }

  void _onOfferUpdated(Event event){
    var oldItemValue = offers.singleWhere((item) => item.id == event.snapshot.key);
    setState((){
      offers[offers.indexOf(oldItemValue)] = new Offer.fromSnapShot(event.snapshot);
    });
  }

  void _deleteOffer(BuildContext context, Offer item,int position)async{
    await offerReference.child(item.id).remove().then((_){// then means server responds nothing (_)
      setState(() {
        offers.removeAt(position);
      });
    });
  }

  void _onVideoAdded(Event event){
    setState((){
      videos.add(new Video.fromSnapShot(event.snapshot));
    });
  }

  void _onVideoUpdated(Event event){
    var oldItemValue = videos.singleWhere((item) => item.id == event.snapshot.key);
    setState((){
      videos[videos.indexOf(oldItemValue)] = new Video.fromSnapShot(event.snapshot);
    });
  }

  void _onTypeAdded(Event event){
    setState((){
      types.add(new Types.fromSnapShot(event.snapshot));
    });
  }

  void _onTypeUpdated(Event event){
    var oldItemValue = types.singleWhere((item) => item.id == event.snapshot.key);
    setState((){
      types[types.indexOf(oldItemValue)] = new Types.fromSnapShot(event.snapshot);
    });
  }

  void _deleteVideo(BuildContext context, Video item,int position)async{
    await videoReference.child(item.id).remove().then((_){
      // then means server responds nothing (_)
      setState(() {
        videos.removeAt(position);
      });
    });
  }

  void _deleteType(BuildContext context, Types item,int position)async{
    await typeReference.child(item.id).remove().then((_){
      // then means server responds nothing (_)
      setState(() {
        types.removeAt(position);
      });
    });
  }


}




