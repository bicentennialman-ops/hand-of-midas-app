import 'package:handofmidas/models/Wallet.dart';

class AppState {
  bool firstLoad;
  bool isLogined;
  String token;
  Wallet wallet;

  AppState(this.firstLoad, this.isLogined, this.token, this.wallet);

  AppState.fromAppState(AppState prevState) {
    isLogined = prevState.isLogined;
    token = prevState.token;
    wallet = prevState.wallet;
  }
}
