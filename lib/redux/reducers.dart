import 'package:backg/models/app_state.dart';
import 'package:backg/models/product.dart';
import 'package:backg/models/user.dart';
import 'package:backg/redux/actions.dart';

AppState appReducer(AppState state, dynamic action) {
  return AppState(
    user: userReducer(state.user, action),
    products: productsReducer(state.products, action)
  );
}

User userReducer(User user, dynamic action) {
  if (action is GetUserAction) {
    //return user from action
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