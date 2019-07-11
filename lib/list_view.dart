
import 'package:flutter/material.dart';
import 'package:la_touche/rate.dart';
import 'package:photo_view/photo_view.dart';

import 'menue_db.dart';

class ItemListView extends StatelessWidget {

  ItemListView({this.data});
  List<Item> data;


bool isLargeScreen = false;

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).size.width > 600) {
      isLargeScreen = true;
    } else {
      isLargeScreen = false;
    }
    return isLargeScreen? tablet() : phone();





  }


  Widget phone(){

    return Scaffold(

        body :

            new
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
                                            '${data[index].description}',
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

                                          child:  GestureDetector(
                                              onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (_) {
                                                return  PhotoView(
                                                  imageProvider: NetworkImage("${data[index].itemImage}"),
                                                );
                                              })),
                                              child: Image.network("${data[index].itemImage}",fit: BoxFit.cover,)

                                          ),

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

                                                          Text('${data[index].rate}'),

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
                                                          Text('${data[index].price}')
                                                        ],
                                                      ),
                                                    ),
                                                  ),

                                                  SizedBox(
                                                    height: 8.0,
                                                  ),
                                                  Text(
                                                    '${data[index].itemName}',
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.w600,
                                                      fontSize: 17,
                                                    ),
                                                  ),



                                                ])),



                                      ],
                                    ),
                                    new Divider(),
                                  ],
                                ),

                                trailing:
                                Column(
                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: ()=> _navigateToRate(context,data[index]),
                                      child:  Text('اضغط هنا للتقيم ',style: TextStyle(fontWeight: FontWeight.bold),),
                                    ),
                                    InkWell(

                                        onTap: ()=> _navigateToRate(context,data[index]),
                                        child:
                                        Icon(Icons.star,color: Colors.pink[100])

                                    ),


                                  ],
                                )

                            );
                          }, itemCount: data.length,)),



                      ],
                    ),

                  ),
                ],
              ),
            ));


  }


  Widget tablet(){
    return Scaffold(

        body :

            new
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
                                            '${data[index].description}',
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

                                          child:  GestureDetector(
                                              onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (_) {
                                                return  PhotoView(
                                                  imageProvider: NetworkImage("${data[index].itemImage}"),
                                                );
                                              })),
                                              child: Image.network("${data[index].itemImage}",fit: BoxFit.cover,)

                                          ),

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

                                                          Text('${data[index].rate}'),

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
                                                          Text('${data[index].price}')
                                                        ],
                                                      ),
                                                    ),
                                                  ),

                                                  SizedBox(
                                                    height: 8.0,
                                                  ),
                                                  Text(
                                                    '${data[index].itemName}',
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

                                trailing:
                                Column(
                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: ()=> _navigateToRate(context,data[index]),
                                      child:  Text('اضغط هنا للتقيم ',style: TextStyle(fontWeight: FontWeight.bold),),
                                    ),
                                    InkWell(

                                        onTap: ()=> _navigateToRate(context,data[index]),
                                        child:
                                        Icon(Icons.star,color: Colors.pink[100])

                                    ),


                                  ],
                                )

                            );
                          }, itemCount: data.length,)),



                      ],
                    ),

                  ),
                ],
              ),
            ));
  }

  void _navigateToRate(BuildContext context,Item item) async {

    await Navigator.push(context,

      MaterialPageRoute(builder: (context) => Rate(item)),
    );

  }

}


/*
@mohammed_7aafar =>(instagram) => instagram.user;
#Flutter_Developer
 */