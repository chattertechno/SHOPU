import 'package:flutter/material.dart';

class Product {
  String name;
  String  description;
  String id;
  num price;
  int size;
  List<dynamic> picture;
  Product({
    this.id,
    this.picture,
    this.name,
    this.price,
    this.description,
    this.size,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      description: json['description'],
      size: json['size'],
      picture: json['picture'],
    );
    
  }
}

