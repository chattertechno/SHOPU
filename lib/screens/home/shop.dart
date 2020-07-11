import 'package:backg/screens/constant.dart';
import 'package:backg/screens/home/components/body.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Body(),
    );
  }
  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(icon: Icon(Icons.arrow_back),
      onPressed: () {},),
      actions: <Widget>[
        IconButton(icon: Icon(Icons.search, color: kTextColor,),
        onPressed: () {},
        ),
        IconButton(icon: Icon(Icons.shopping_cart, color: kTextColor,),
        onPressed: () {},
        ),
        SizedBox(width: kDefaultPaddin / 2,)
      ],
      
    );
  }
}