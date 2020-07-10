import 'package:backg/screens/constant.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Search Order"),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/pastel.jpg"),
                    fit: BoxFit.cover)),
          ),
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 100,
                ),
                Text(
                  'Order Number',
                  style: kLabelStyle,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  decoration: kBoxDecorationStyle,
                  height: 60.0,
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    style:
                        TextStyle(color: Colors.white, fontFamily: 'OpenSans'),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(top: 14.0),
                        prefixIcon: Icon(
                          Icons.email,
                          color: Colors.white,
                        ),
                        hintText: 'Enter your order number',
                        hintStyle: kHintTextStyle),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Enter Your number',
                  style: kLabelStyle,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  decoration: kBoxDecorationStyle,
                  height: 60.0,
                  child: TextField(
                    style:
                        TextStyle(color: Colors.white, fontFamily: 'OpenSans'),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(top: 14.0),
                        prefixIcon: Icon(
                          Icons.branding_watermark,
                          color: Colors.white,
                        ),
                        hintText: 'Enter your phone number to search',
                        hintStyle: kHintTextStyle),
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: FlatButton(
                    onPressed: () => print('Search'),
                    padding: EdgeInsets.only(right: 0.0),
                    child: Text(
                      'Forgot order number',
                      style: kLabelStyle,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                  width: double.infinity,
                  child: RaisedButton(
                    elevation: 5.0,
                    onPressed: () => print("logged in"),
                    padding: EdgeInsets.all(15.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    color: Colors.white,
                    child: Text(
                      'search',
                      style: TextStyle(
                          color: Color(0xFF527DAA),
                          letterSpacing: 1.5,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'OpenSans'),
                    ),
                  ),
                ),
          //       Column(
          //         children: <Widget>[
          //           Center(
          //             child: Text(
          //               '- OR - ',
          //               style: TextStyle(
          //                   color: Colors.white, fontWeight: FontWeight.w400
          //                   ),
          //             ),
          //           ),
          //           SizedBox(height: 10.0,),
          //           Text('Sign In With',
          //             style: kLabelStyle,
          //           )
          //         ],
          //       ),
          //       Padding(
          //   padding: EdgeInsets.symmetric(vertical: 30.0),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //     children: <Widget>[
          //       _buildsocialbtn(
          //         () => print("hello dude00"),
          //         AssetImage('assets/images/facebook.jpg')
          //         ),
          //         _buildsocialbtn(
          //           () => print("fuckoff"),
          //           AssetImage('assets/images/facebook.jpg')
          //         )
          //     ],
          //   ),
          // )
              ],
            ),
            
          ),
          
        ],
      ),
    );
  }
}

Widget _buildsocialbtn(Function onTap, AssetImage logo) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60.0,
        width: 60.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 2),
              blurRadius: 6.0,
            ),
          ],
          image: DecorationImage(
            image: logo,
          ),
        ),
      ),
    );
}