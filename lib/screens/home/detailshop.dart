import 'package:backg/models/app_state.dart';
import 'package:backg/models/product.dart';
import 'package:backg/models/user.dart';
import 'package:backg/screens/home/detailed_shop.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:badges/badges.dart';

import '../constant.dart';

class DetailShop extends StatefulWidget {
  final Product product;
  DetailShop({this.product});

  @override
  _DetailShopState createState() => _DetailShopState();
}

class _DetailShopState extends State<DetailShop> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.product.color,
      appBar: buildAppBar, 
      body: DetailedShop(
        product: widget.product,
      ),
    );
  }

  final buildAppBar = PreferredSize(
    preferredSize: Size.fromHeight(60),
    child: StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (context, state) {
       
        var value = state.cartProducts.length;
        return AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: SvgPicture.asset(
              'assets/icons/back.svg',
              color: Colors.black,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          actions: <Widget>[
            state.user != null ?
            IconButton(
              icon: SvgPicture.asset("assets/icons/search.svg"),
              onPressed: () {},
            ) : Text(''),
            state.user != null ?
            Badge(
              showBadge: value < 1 == false,
              badgeContent: Text('$value'),
              position: BadgePosition.topRight(top: 0.001, right: 2),
              child: IconButton(
                icon: SvgPicture.asset("assets/icons/cart.svg"),
                onPressed: () => Navigator.pushNamed(context, '/cart'),
              ),
            ) : Text(''),
            SizedBox(width: kDefaultPaddin / 2)
          ],
        );
      },
    ),
  );
}
