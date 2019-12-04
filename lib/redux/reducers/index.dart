import 'package:handofmidas/models/AppState.dart';
import 'package:handofmidas/redux/actions.dart';

AppState reducer(AppState prevState, dynamic action) {
  AppState newAppState = AppState.fromAppState(prevState);
  if (action is InitApp)
    newAppState = action.appState;
  else if (action is Login) {
    newAppState.isLogined = true;
    newAppState.token = action.token;
  } else if (action is SelectWallet) {
    newAppState.wallet = action.wallet;
  }
  return newAppState;
}
