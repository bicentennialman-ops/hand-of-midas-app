import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:handofmidas/constants/app_themes.dart';
import 'package:handofmidas/database/wallet.dart';
import 'package:handofmidas/models/TimeType.dart';
import 'package:handofmidas/redux/reducers/index.dart';
import 'package:handofmidas/screens/AddWallet.dart';
import 'package:handofmidas/screens/ListExchanges.dart';
import 'package:handofmidas/screens/LoginScreen.dart';
import 'package:handofmidas/services/user.dart';
import 'package:handofmidas/utils/index.dart';
import 'package:redux/redux.dart';
import 'localizations.dart';

import 'models/AppState.dart';

void main() async {
  var setting = await getSetting();
  AppState _initialState;
  if (setting == null) {
    TimeType timeType = TimeType(1, DateTime.now(), 10);
    setup("timeType", timeType.toMap());
    _initialState = AppState(timeType, true, false, null, null);
  } else {
    String token = await storage.read(key: "token");
    TimeType timeType = TimeType(1, DateTime.now(), 10);
    setup("timeType", timeType.toMap());
    try {
      String newToken = await renewToken(token);

      //TimeType timeType = TimeType.fromMap(setting["timeType"]);
      if (newToken == "")
        _initialState = AppState(
            timeType,
            false,
            false,
            "",
            setting["walletId"] != null
                ? await WalletProvider()
                    .getWallet(int.parse(setting["walletId"].toString()))
                : null);
      else {
        await storage.write(key: "token", value: newToken);
        _initialState = AppState(
            timeType,
            false,
            true,
            newToken,
            setting["walletId"] != null
                ? await WalletProvider()
                    .getWallet(int.parse(setting["walletId"].toString()))
                : null);
      }
    } catch (err) {
      _initialState = AppState(
          timeType,
          false,
          true,
          token,
          setting["walletId"] != null
              ? await WalletProvider()
                  .getWallet(int.parse(setting["walletId"].toString()))
              : null);
    }
  }

  final Store<AppState> _store =
      Store<AppState>(reducer, initialState: _initialState);
  runApp(MyApp(store: _store));
}

class MyApp extends StatefulWidget {
  final Store<AppState> store;
  MyApp({this.store});

  @override
  _MyAppState createState() => _MyAppState(store);
}

class _MyAppState extends State<MyApp> {
  _MyAppState(this.store);
  final Store<AppState> store;
  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
          localizationsDelegates: [
            new AppLocalizationsDelegate(),
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [
            const Locale('en', ''),
            const Locale('vi', ''),
          ],
          theme: themeData,
          home: store.state.isLogined
              ? store.state.wallet == null
                  ? AddWalletScreen()
                  : ListExchangesScreen(store.state.timeType)
              : LoginScreen()),
    );
  }
}
