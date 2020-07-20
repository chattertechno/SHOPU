import 'package:backg/models/product.dart';
import 'package:flutter/material.dart';
import '../../constant.dart';
import '../../../models/product.dart';

class ItemCard extends StatelessWidget {
  final Product product;
  final Function press;
  const ItemCard({
    this.product,
    this.press,
  });
  @override
  Widget build(BuildContext context) {
    final String pictureUrl = 'https://serviceslikeme.herokuapp.com${product.image['url']}';
    return GestureDetector(
      onTap: press,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            
            child: Container(
              padding: EdgeInsets.all(kDefaultPaddin),
              decoration: BoxDecoration(
                color: Color(0XF3BBD9),
                borderRadius: BorderRadius.circular(16)
              ),
              child: Hero(
                tag: "${product.id}",
                child: Image.network(pictureUrl, fit: BoxFit.cover,),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin / 4),
            child: Text(product.title, style: TextStyle(color: kTextLightColor),),
          ),
          Text("\$${product.price}", style: TextStyle(fontWeight: FontWeight.bold),),
        
        ],
      ),
    );
  }
}