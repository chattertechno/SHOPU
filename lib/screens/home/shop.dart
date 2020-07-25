import 'dart:convert';

import 'package:backg/models/app_state.dart';
import 'package:backg/models/product.dart';
import 'package:backg/redux/actions.dart';
import 'package:backg/screens/constant.dart';
import 'package:backg/screens/home/components/body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  final Product product;
  final void Function() onInit;
  HomeScreen({this.onInit, this.product});
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
            title: SizedBox(
              child: state.user != null
                  ? Text(state.user.username,
                      style: TextStyle(backgroundColor: Colors.black))
                  : FlatButton(
                      onPressed: () => Navigator.pushNamed(context, '/signup'),
                      child: Text('Register Here', style: TextStyle(fontSize: 22),),
                    ),
            ),
            backgroundColor: Colors.white,
            elevation: 0,
            leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: StoreConnector<AppState, VoidCallback>(
                  converter: (store) {
                    return () => store.dispatch(logoutUserAction);
                  },
                  builder: (_, callback) {
                    return state.user != null
                        ? IconButton(
                            icon: Icon(
                              Icons.exit_to_app,
                              color: Colors.black,
                            ),
                            onPressed: callback,
                          )
                        : Text('');
                  },
                )),
            actions: <Widget>[
              state.user != null ?
              IconButton(
                icon: SvgPicture.asset ("assets/icons/cart.svg", color: Colors.black,),
                onPressed: () => Navigator.pushNamed(context, '/cart'),
              ) : Text(''),
              SizedBox(
                width: kDefaultPaddin / 2,
              )
            ],
          );
        }),
  );
}
