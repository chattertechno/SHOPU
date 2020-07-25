import 'package:backg/models/product.dart';
import 'package:backg/redux/reducers.dart';
import 'package:backg/screens/home/detailed_shop.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:badges/badges.dart';

import '../constant.dart';

class DetailShop extends StatelessWidget {
  final Product product;
  DetailShop({this.product});

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      backgroundColor: product.color,
      appBar: buildAppBar(context),
      body: DetailedShop(
        product: product,
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: product.color,
      elevation: 0,
      leading: IconButton(
        icon: SvgPicture.asset(
          'assets/icons/back.svg',
          color: Colors.black,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      actions: <Widget>[
        IconButton(
          icon: SvgPicture.asset("assets/icons/search.svg"),
          onPressed: () {},
        ),
        Badge(
          showBadge: false,
          badgeContent: null,
          position: BadgePosition.topRight(top: 0.001, right: 2),
          child: IconButton(
            icon: SvgPicture.asset("assets/icons/cart.svg"),
            onPressed: () => Navigator.pushNamed(context, '/cart'),
          ),
        ),
        SizedBox(width: kDefaultPaddin / 2)
      ],
    );
  }
}
