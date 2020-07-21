import 'package:backg/models/product.dart';
import 'package:backg/screens/home/detailed_shop.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constant.dart';

class DetailShop extends StatelessWidget {
  final Product product;
  DetailShop({ this.product });
  @override
  Widget build(BuildContext context) {

    return Scaffold( 
      backgroundColor: product.color,
      appBar: buildAppBar(context),
      body: DetailedShop(product: product,),
    );
  }
  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: product.color,
      elevation: 0,
      leading: IconButton(
        icon: SvgPicture.asset(
          'assets/icons/back.svg',
          color: Colors.white,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      actions: <Widget>[
        IconButton(
          icon: SvgPicture.asset("assets/icons/search.svg"),
          onPressed: () {},
        ),
        IconButton(
          icon: SvgPicture.asset("assets/icons/cart.svg"),
          onPressed: () {},
        ),
        SizedBox(width: kDefaultPaddin / 2)
      ],
    );
  }
}


