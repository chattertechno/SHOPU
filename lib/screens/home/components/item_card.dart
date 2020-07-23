import 'package:backg/models/product.dart';
import 'package:backg/screens/home/detailshop.dart';
import 'package:backg/screens/products/products.dart';
import 'package:flutter/material.dart';
import '../../constant.dart';
import '../../../models/product.dart';
import '../detailed_shop.dart';

class ItemCard extends StatelessWidget {
  final Product product;
  final Function press;
  const ItemCard({
    this.product,
    this.press,
  });
  @override
  Widget build(BuildContext context) {
    final String pictureUrl = 
        'https://api.jephcakes.com${product.picture[0]['url']}';
    return InkWell(
      onTap: press, 
      child: GestureDetector(
        onTap: () =>
        Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) {
            return DetailShop(product: product);
          }
        )
      ),
        
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Container(
                padding: EdgeInsets.all(kDefaultPaddin),
                decoration: BoxDecoration(
                    color: product.color,
                    borderRadius: BorderRadius.circular(16)),
                child: Hero(
                  tag: "${product.id}",
                  child: Image.network(
                    pictureUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin / 4),
              child: Text(
                product.name.toUpperCase(),
                style: TextStyle(color: kTextLightColor),
              ),
            ),
            Text(
              "\$${product.price}",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
