import 'package:handofmidas/models/AppState.dart';
import 'package:handofmidas/models/TimeType.dart';
import 'package:handofmidas/models/Wallet.dart';

class InitApp {
  final AppState appState;
  InitApp(this.appState);
}

class Login {
  final String token;
  Login(this.token);
}

class SelectWallet {
  final Wallet wallet;
  SelectWallet(this.wallet);
}

class ChangeTimeType {
  final TimeType timeType;
  ChangeTimeType(this.timeType);
}
