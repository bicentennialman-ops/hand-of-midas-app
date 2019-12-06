import 'package:handofmidas/models/TimeType.dart';
import 'package:handofmidas/models/Wallet.dart';

class AppState {
  bool firstLoad;
  bool isLogined;
  String token;
  Wallet wallet;
  TimeType timeType;

  AppState(
      this.timeType, this.firstLoad, this.isLogined, this.token, this.wallet);

  AppState.fromAppState(AppState prevState) {
    isLogined = prevState.isLogined;
    token = prevState.token;
    wallet = prevState.wallet;
    firstLoad = prevState.firstLoad;
    timeType = prevState.timeType;
  }
}
