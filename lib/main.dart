import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:handofmidas/constants/app_themes.dart';
import 'package:handofmidas/redux/reducers/index.dart';
import 'package:handofmidas/screens/ListExchanges.dart';
import 'package:handofmidas/screens/LoginScreen.dart';
import 'package:redux/redux.dart';
import 'localizations.dart';

import 'models/AppState.dart';

void main() {
  final _initialState = AppState(false, "", null);
  final Store<AppState> _store =
      Store<AppState>(reducer, initialState: _initialState);
  runApp(MyApp(store: _store));
}

class MyApp extends StatelessWidget {
  final Store<AppState> store;

  MyApp({this.store});

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        localizationsDelegates: [
          new AppLocalizationsDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        supportedLocales: [Locale("en"), Locale("vi")],
        theme: themeData,
        home: LoginScreen(),
      ),
    );
  }
}
