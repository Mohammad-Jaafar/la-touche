/*

@Mohammed_7aafar -> instagram
07711915028
#flutter_Developer

 */

import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:la_touche/qr/home_screen.dart';
import 'package:la_touche/rate.dart';
import 'package:la_touche/type_db.dart';
import 'package:la_touche/video_helper.dart';
import 'package:la_touche/videos.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:photo_view/photo_view.dart';


import 'admin.dart';

import 'list_view.dart';
import 'menue_db.dart';
import 'offers.dart';

import 'package:chewie/chewie.dart';


import 'package:video_player/video_player.dart';








class MyHomePage extends StatefulWidget {



  @override
  _MyHomePageState createState()  => new _MyHomePageState();

}

final itemReference = FirebaseDatabase.instance.reference().child('Items');
final offerReference = FirebaseDatabase.instance.reference().child('Offers');
final videoReference = FirebaseDatabase.instance.reference().child('Videos');
final typeReference = FirebaseDatabase.instance.reference().child('Types');

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {


  TabController _tabController;

  //VideoPlayerController _controller;
  //Future<void> _initializeVideoPlayerFuture;

  List<Item> x;

  var rating;
  List<Item> itemz;
  List<Offer> offers;
  List<Video> videos;
  List<Types> types;
  bool _isLoading = true;

  StreamSubscription<
      Event> _onItemAddedSubscription; // listner for the firebase to update the list ..
  StreamSubscription<Event> _onItemChangedSubscription;

  StreamSubscription<
      Event> _onOfferAddedSubscription; // listner for the firebase to update the list ..
  StreamSubscription<Event> _onOfferChangedSubscription;

//
  StreamSubscription<
      Event> _onVideoAddedSubscription; // listner for the firebase to update the list ..
  StreamSubscription<Event> _onVideoChangedSubscription;

  StreamSubscription<
      Event> _onTypeAddedSubscription; // listner for the firebase to update the list ..
  StreamSubscription<Event> _onTypeChangedSubscription;

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  new GlobalKey<RefreshIndicatorState>();


  @override
  void initState() {
    // bring data from firebase whenever the app starts .....
    super.initState();
    itemz = new List();
    offers = new List();
    videos = new List();
    types = new List();
    rating = 0.0;
    _tabController = new TabController(length: 4, vsync: this);

    _onItemAddedSubscription = itemReference.onChildAdded.listen(_onItemAdded);
    _onItemChangedSubscription =
        itemReference.onChildChanged.listen(_onItemUpdated);


    _onOfferAddedSubscription =
        offerReference.onChildAdded.listen(_onOfferAdded);
    _onOfferChangedSubscription =
        offerReference.onChildChanged.listen(_onOfferUpdated);
//
    _onVideoAddedSubscription =
        videoReference.onChildAdded.listen(_onVideoAdded);
    _onVideoChangedSubscription =
        videoReference.onChildChanged.listen(_onVideoUpdated);


    _onTypeAddedSubscription = typeReference.onChildAdded.listen(_onTypeAdded);
    _onTypeChangedSubscription =
        typeReference.onChildChanged.listen(_onTypeUpdated);



  }

  @override
  void dispose() {
    /// close database .....
    // TODO: implement dispose
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


bool isLargeScreen=false;

  @override
  Widget build(BuildContext context) {


    if(MediaQuery.of(context).size.width > 600){

      isLargeScreen =true;
    }
    else {

      isLargeScreen =false;

    }

    Widget offer1() {
      return
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

                  Text('${offers[index].offerTitle}',
                    style: TextStyle(color: Colors.pink),),

                  offers[index].offerImage != null
                      ? GestureDetector(
                      onTap: () =>
                          Navigator.push(
                              context, MaterialPageRoute(builder: (_) {
                            return PhotoView(
                              imageProvider: NetworkImage(
                                  "${offers[index].offerImage}"),
                            );
                          })),
                      child: Image.network("${offers[index].offerImage}")
                  )
                      : Text('error'),


                  Align(
                      alignment: Alignment.center,
                      child: Text(
                        '${offers[index].offerDetails}', style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                      )),


                ],
              ),
            );
          },
          staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,
        );
    }


    Widget offer2() {
      return
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

                  Text('${offers[index].offerTitle}',
                    style: TextStyle(color: Colors.pink),),

                  offers[index].offerImage != null
                      ? GestureDetector(
                      onTap: () =>
                          Navigator.push(
                              context, MaterialPageRoute(builder: (_) {
                            return PhotoView(
                              imageProvider: NetworkImage(
                                  "${offers[index].offerImage}"),
                            );
                          })),
                      child: Image.network("${offers[index].offerImage}")
                  )
                      : Text('error'),


                  Align(
                      alignment: Alignment.center,
                      child: Text(
                        '${offers[index].offerDetails}', style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                      )),


                ],
              ),
            );
          },
          staggeredTileBuilder: (int index) => StaggeredTile.fit(2),
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,
        );
    }


    Widget video1() {
      return Scaffold(
        body:
        StaggeredGridView.countBuilder(
          crossAxisCount: 4,
          itemCount: videos.length,
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

                  ChewieListItem(
                    videoPlayerController: VideoPlayerController.network(
                      '${videos[index].video}',
                    ),
                    looping: false,
                  ),


                ],
              ),
            );
          },
          staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,
        ),
      );
    }


    Widget video2(){

      return  Scaffold(
        body:
        new Container(child: ListView.builder(
          shrinkWrap: true,
          itemBuilder: (context, index) {

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

                    ],
                  ),
                ),
              ),
            );
          },
          scrollDirection: Axis.vertical,
          itemCount: videos.length,
        )),


      );


    }


    Widget menue1() {
      return
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
                    onTap: () =>
                        Navigator.push(
                            context, MaterialPageRoute(builder: (_) {
                          x = itemz.where((i) => i.type ==
                              types[index].typeName)
                              .toList();
                          return ItemListView(data: x);
                        }

                        )),

                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Image.network("${types[index].typeImage}"),
                          Align(
                              alignment: Alignment.center,
                              child: Text('${types[index].typeName}', style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                              )),
                        ],
                      ),
                    ),

                  ) : Text('error'),

                ],
              ),
            );
          },
          staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,
        );
    }

    Widget menue2() {
      return
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
                      onTap: () =>
                          Navigator.push(
                              context, MaterialPageRoute(builder: (_) {
                            x = itemz.where((i) => i.type ==
                                types[index].typeName)
                                .toList();
                            return ItemListView(data: x);
                          }

                          )),

                      child: Container(
                      child: Column(
                      children: <Widget>[
                        Image.network("${types[index].typeImage}"),
                        Align(
                            alignment: Alignment.center,
                            child: Text('${types[index].typeName}', style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                            )),
                      ],
                      ),
                      ),

                  ) : Text('error'),


                ],
              ),
            );
          },
          staggeredTileBuilder: (int index) => StaggeredTile.fit(2),
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,
        );
    }


    Widget loyaltyprogram(){


      return Container(
        child: Center(
          child: Column(
            children:[

           RaisedButton(
             onPressed: (){
               Navigator.push(context, MaterialPageRoute(builder: (context) {
                 return HomeScreen();
               }));
             },
             child: Text('enter'),
           )


               ]
          ),
        ),
      );








    }












    // tabBar view

    return new Scaffold(


        resizeToAvoidBottomPadding: true,
        resizeToAvoidBottomInset: true,


        backgroundColor: Colors.white,

        appBar: AppBar(
          title: Text('La Touche', style: TextStyle(color: Colors.pink[100],
              fontWeight: FontWeight.bold,
              fontSize: 18),),

          leading: Icon(FontAwesomeIcons.umbrella, color: Colors.pink[100],),
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
                icon: new Icon(FontAwesomeIcons.star),
              ),
              new Tab(
                icon: new Icon(FontAwesomeIcons.percentage),
              ),
              new Tab(
                icon: new Icon(FontAwesomeIcons.iceCream),
              )
            ],
            controller: _tabController,
            indicatorColor: Colors.white,
            indicatorSize: TabBarIndicatorSize.tab,),
          bottomOpacity: 1,
        ),

        body:

        TabBarView(children:

        [

          isLargeScreen ? menue1() : menue2(),

          loyaltyprogram(),

          isLargeScreen ? offer1() : offer2(),

          isLargeScreen ? video1() : video2(),


        ],
          controller: _tabController,
        ),


        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              if (!mounted) return;
              _isLoading = false;
            });


            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return Admin();
            }));
          },
          tooltip: 'Add menue',
          backgroundColor: Colors.pink[100],
          child:

          Icon(FontAwesomeIcons.signInAlt, color: Colors.black,),
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

  void _onItemAdded(Event event) {
    setState(() {
      itemz.add(new Item.fromSnapShot(event.snapshot));
    });
  }

  void _onItemUpdated(Event event) {
    var oldItemValue = itemz.singleWhere((item) =>
    item.id == event.snapshot.key);
    setState(() {
      itemz[itemz.indexOf(oldItemValue)] =
      new Item.fromSnapShot(event.snapshot);
    });
  }


  void _onOfferAdded(Event event) {
    setState(() {
      offers.add(new Offer.fromSnapShot(event.snapshot));
    });
  }

  void _onOfferUpdated(Event event) {
    var oldItemValue = offers.singleWhere((item) =>
    item.id == event.snapshot.key);
    setState(() {
      offers[offers.indexOf(oldItemValue)] =
      new Offer.fromSnapShot(event.snapshot);
    });
  }


  void _onVideoAdded(Event event) {
    setState(() {
      videos.add(new Video.fromSnapShot(event.snapshot));
    });
  }

  void _onVideoUpdated(Event event) {
    var oldItemValue = videos.singleWhere((item) =>
    item.id == event.snapshot.key);
    setState(() {
      videos[videos.indexOf(oldItemValue)] =
      new Video.fromSnapShot(event.snapshot);
    });
  }

  void _onTypeAdded(Event event) {
    setState(() {
      types.add(new Types.fromSnapShot(event.snapshot));
    });
  }

  void _onTypeUpdated(Event event) {
    var oldItemValue = types.singleWhere((item) =>
    item.id == event.snapshot.key);
    setState(() {
      types[types.indexOf(oldItemValue)] =
      new Types.fromSnapShot(event.snapshot);
    });
  }

}