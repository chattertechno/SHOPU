import 'package:backg/models/app_state.dart';
import 'package:backg/models/product.dart';
import 'package:backg/redux/actions.dart';
import 'package:backg/screens/constant.dart';
import 'package:backg/screens/home/components/body.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';

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
  

  int currentindex = 0;
  final List<Widget> _children = [
    Body(),
    Text('Hello World'),
    Text('Hey dude'),
    Text('dude')
  ];

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (context, state) {
          // final User user = state.user;
          return Scaffold(
            bottomNavigationBar: state.user != null
                ? BottomNavyBar(
                    showElevation: true,
                    selectedIndex: currentindex,
                    onItemSelected: (index) => setState(() {
                      currentindex = index;
                    }),
                    items: [
                      BottomNavyBarItem(
                        icon: Icon(Icons.shop_two),
                        title: Text('Cakes'),
                        activeColor: Colors.red,
                        textAlign: TextAlign.center,
                      ),
                      BottomNavyBarItem(
                        icon: Icon(Icons.pan_tool),
                        title: Text('Tools'),
                        activeColor: Colors.purpleAccent,
                        textAlign: TextAlign.center,
                      ),
                      BottomNavyBarItem(
                        icon: Icon(Icons.favorite),
                        title: Text(
                          'Favorites',
                        ),
                        activeColor: Colors.pink,
                        textAlign: TextAlign.center,
                      ),
                      BottomNavyBarItem(
                        icon: Icon(Icons.settings),
                        title: Text('Settings'),
                        activeColor: Colors.blue,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  )
                : Text(''),
            appBar: buildAppBar,
            body: _children[currentindex],
          );
        });
  }

  final buildAppBar = PreferredSize(
    preferredSize: Size.fromHeight(60.0),
    child: StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (context, state) {
          var value = state.cartProducts.length;
          return AppBar(
            centerTitle: true,
            title: SizedBox(
              child: state.user != null
                  ? Text(state.user.username,
                      style: TextStyle(color: Colors.black))
                  : Text(
                      'Jeph Cakes:',
                      style: TextStyle(fontSize: 22, color: Colors.black),
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
              state.user != null
                  ? Badge(
                      position: BadgePosition.topRight(top: 2, right: 3),
                      badgeContent: Text('$value'),
                      showBadge: value < 1 == false,
                      child: IconButton(
                        icon: SvgPicture.asset(
                          "assets/icons/cart.svg",
                          color: Colors.black,
                        ),
                        onPressed: () => Navigator.pushNamed(context, '/cart'),
                      ),
                    )
                  : Text(''),
              SizedBox(
                width: kDefaultPaddin / 2,
              )
            ],
          );
        }),
  );
}
