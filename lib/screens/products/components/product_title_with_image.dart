import 'package:backg/models/product.dart';
import 'package:flutter/material.dart';

import '../../constant.dart';

class ProductTitleWithImage extends StatelessWidget {
  final Product item;
  ProductTitleWithImage({
    @required this.item, Product product,
  });

  

  @override
  Widget build(BuildContext context) {
    final String pictureUrl =
        'https://serviceslikeme.herokuapp.com${item.picture[0]['url']}';
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Baked cake",
            style: TextStyle(color: Colors.white),
          ),
          Text(
            item.name,
            style: Theme.of(context)
                .textTheme
                .headline4
                .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: kDefaultPaddin),
          Row(
            children: <Widget>[
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(text: "Price\n"),
                    TextSpan(
                      text: "\$${item.price}",
                      style: Theme.of(context).textTheme.headline4.copyWith(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(width: kDefaultPaddin),
              Expanded(
                child: Hero(
                  tag: "${item.id}",
                  child: Image.network(
                    pictureUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
