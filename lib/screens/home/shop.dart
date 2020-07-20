import 'dart:convert';

import 'package:backg/screens/constant.dart';
import 'package:backg/screens/home/components/body.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void initState() {
    super.initState();
  _getUser();
  }
  _getUser() async {
    final prefs = await SharedPreferences.getInstance();
    var storedUser = prefs.getString('user');
    print(json.decode(storedUser));
  }

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