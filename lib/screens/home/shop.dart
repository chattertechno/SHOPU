import 'dart:convert';

import 'package:backg/models/app_state.dart';
import 'package:backg/screens/constant.dart';
import 'package:backg/screens/home/components/body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  final void Function() onInit;
  HomeScreen({this.onInit});
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void initState() {
    super.initState();
    widget.onInit();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (context, state) {
          return Scaffold(
            appBar: buildAppBar,
            body: Body(),
          );
        });
  }

  final buildAppBar = PreferredSize(
    preferredSize: Size.fromHeight(60.0),
    child: StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (context, state) {
          return AppBar(
            centerTitle: true,
            title: SizedBox(child: state.user != null ? Text(state.user.username) : Text(''),),
            backgroundColor: Colors.yellow,
            elevation: 0,
            leading:  Padding(
              padding: const EdgeInsets.all(8.0),
              child: state.user != null ? IconButton(
                icon: Icon(Icons.exit_to_app),
                onPressed: () {},
              ) : Text(''),
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.shopping_cart,
                  color: kTextColor,
                ),
                onPressed: () {},
              ),
              SizedBox(
                width: kDefaultPaddin / 2,
              )
            ],
          );
        }),
  );
}
