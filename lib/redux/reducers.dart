import 'package:backg/models/app_state.dart';
import 'package:backg/models/order.dart';
import 'package:backg/models/product.dart';
import 'package:backg/models/user.dart';
import 'package:backg/redux/actions.dart';

AppState appReducer(AppState state, dynamic action) {
  return AppState(
    user: userReducer(state.user, action),
    products: productsReducer(state.products, action),
    cartProducts: cartProducts(state.cartProducts, action),
    cards: cardsReducer(state.cards, action),
    cardToken: cardTokenReducer(state.cardToken, action),
    orders: ordersReducer(state.orders, action),
    favorites: favoritesReducer(state.favorites, action)
  );
}

User userReducer(User user, dynamic action) {
  if (action is GetUserAction) {
    //return user from action
    return action.user;
  } else if (action is LogoutUserAction) {
    return action.user;
  }
  return user;
}

List<Product> productsReducer(List<Product> products, dynamic action) {
  if (action is GetProductsAction) {
    return action.products;
  }
  return products;
}

List<Product> cartProducts(List<Product> cartProducts, dynamic action) {
  if (action is GetCartProductsAction) {
    return action.cartProducts;
  } else if (action is ToggleCartProductAction) {
    return action.cartProducts;
  } else if (action is ClearCartProductsAction) {
    return action.cartProducts;
  }
  return cartProducts;
}
List<Product> favoritesReducer(List<Product> favorites, dynamic action) {
  return favorites;
}

List<dynamic> cardsReducer(List<dynamic> cards, dynamic action) {
  if (action is GetCardsAction) {
    return action.cards;
  } else if (action is AddCardAction) {
    return List.from(cards)..add(action.card);
  }
  return cards;
}

String cardTokenReducer(String cardToken, dynamic action) {
  if (action is UpdateCardTokenAction) {
    return action.cardToken;
  }
  return cardToken;
}

List<Order> ordersReducer(List<Order> orders, dynamic action) {
  if (action is AddOrderAction) {
    return List.from(orders)..add(action.order);
  }
  return orders;
} 
