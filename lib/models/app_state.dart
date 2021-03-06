import 'package:backg/models/order.dart';
import 'package:backg/models/product.dart';
import 'package:backg/models/user.dart';
import 'package:meta/meta.dart';
@immutable

class AppState {
  final User user;
  final List<Product> products;
  final List<Product> cartProducts;
  final List<dynamic> cards;
  final String cardToken;
  final List<Order> orders;
  final List<Product> favorites;

  AppState({ @required this.user, @required this.products, @required this.cartProducts, @required this.cards, @required this.cardToken, @required this.orders, @required this.favorites});

  factory AppState.initial() {
    return AppState(
      user: null,
      products: [],
      cartProducts: [],
      cards: [],
      cardToken: '',
      orders: [],
      favorites: []
    );
  }
}