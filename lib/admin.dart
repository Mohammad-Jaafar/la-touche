
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'add_menue.dart';


class Admin extends StatefulWidget {




  @override
  _MyHomePageState createState()  => new _MyHomePageState();

}

class _MyHomePageState extends State<Admin> {


  TextEditingController _pass;

  @override
  void initState() {
    // bring data from firebase whenever the app starts .....
    super.initState();
    _pass = new TextEditingController();
    _pass.clear();
  }

@override
Widget build(BuildContext context) {




  Size size = MediaQuery.of(context).size;
  return Scaffold(
      body: new Stack(

          children: <Widget>[

            Center(
              child: new Image.asset(
                'assets/images/menue.jpg',
                width: size.width,
                height: size.height,
                fit: BoxFit.fill,

              ),
            ),
            Container(
                child:Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                    new TextFormField(

                      decoration: new InputDecoration(


                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        labelText: "كلمة المرور",
                        labelStyle: TextStyle(color: Colors.white),
                        fillColor: Colors.pink[400],

                        icon: Icon(Icons.vpn_key, color: Colors.white,),
                        focusedBorder:OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white, width: 0.0),
                        ),
                      ),
                      style: TextStyle(color: Colors.pink[100]),
                      obscureText: true,
                      cursorColor: Colors.pink[100],
                      keyboardType: TextInputType.text,
                     controller: _pass,
                    ),





                  ],
                )
            )
          ]
      ),

    floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    floatingActionButton: FloatingActionButton(
      onPressed: () {


        if(_pass.text == 'la2020la') {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return AddItem();
          }));
        }
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

}