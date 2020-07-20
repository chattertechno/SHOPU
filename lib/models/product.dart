import 'package:flutter/material.dart';

class Product {
  String title, description, id;
  int price, size;
  Map<String, dynamic> image;
  Product({
    this.id,
    this.image,
    this.title,
    this.price,
    this.description,
    this.size,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      price: json['price'],
      description: json['description'],
      size: json['size'],
      image: json['image'],
    );
  }
}
