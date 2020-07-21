import 'dart:convert';

import 'package:flutter/material.dart';

class Product {
  String name;
  String  description;
  String id;
  num price;
  int size;
  List<dynamic> picture;
  Color color;
  Product({
    this.id,
    this.picture,
    this.name,
    this.price,
    this.description,
    this.size,
    this.color
  });
 
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      description: json['description'],
      size: json['size'],
      picture: json['picture'],
      color: Color(int.parse("0x${json['color']}")),
    );
    
  }
}

