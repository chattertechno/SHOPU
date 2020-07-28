import 'package:backg/models/app_state.dart';
import 'package:backg/redux/actions.dart';
import 'package:backg/redux/reducers.dart';
import 'package:backg/screens/cart/cart_page.dart';
import 'package:backg/screens/constant.dart';
import 'package:backg/screens/home/shop.dart';
import 'package:backg/screens/homepage.dart';
import 'package:backg/screens/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_logging/redux_logging.dart';
import 'package:redux_thunk/redux_thunk.dart';

void main() {
  final store = Store<AppState>(appReducer,
      initialState: AppState.initial(),
      middleware: [thunkMiddleware, LoggingMiddleware.printer()]);
  runApp(MyApp(store: store));
}

class MyApp extends StatelessWidget {
  final Store<AppState> store;
  MyApp({this.store});
  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Jeph Cakes',
        routes: {
          '/': (BuildContext context) => HomeScreen(onInit: () {
                // dispatch get useraction yo take user data
                StoreProvider.of<AppState>(context).dispatch(getUserAction);
                // dispatch products to grad products
                StoreProvider.of<AppState>(context).dispatch(getProductsAction);
                // get carts product
                StoreProvider.of<AppState>(context)
                    .dispatch(getCartProductsAction);
              }),
          '/signup': (BuildContext context) => SignUpPage(),
          '/login': (BuildContext context) => Homepage(),
          '/cart': (BuildContext contet) => CartPage(onInit: () {
            StoreProvider.of<AppState>(context).dispatch(getCardsAction);
          }),
        },
        theme: ThemeData(
            textTheme: Theme.of(context).textTheme.apply(bodyColor: kTextColor),
            visualDensity: VisualDensity.adaptivePlatformDensity),
      ),
    );
  }
}
