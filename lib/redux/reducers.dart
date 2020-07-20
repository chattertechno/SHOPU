import 'package:backg/models/app_state.dart';
import 'package:backg/models/user.dart';
import 'package:backg/redux/actions.dart';

AppState appReducer(AppState state, dynamic action) {
  return AppState(
    user: userReducer(state.user, action),
  );
}

User userReducer(User user, dynamic action) {
  if (action is GetUserAction) {
    //return user from action
    return action.user;
  }
  return user;
}