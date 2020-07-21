
import 'package:backg/models/product.dart';
import 'package:flutter/material.dart';

import '../../constant.dart';

class Description extends StatelessWidget {
   final Product product;
  Description({
    @required this.product,
  });

 

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: kDefaultPaddin),
      child: Text(product.description, style: TextStyle(height: 1.5),
      ),
    );
  }
}