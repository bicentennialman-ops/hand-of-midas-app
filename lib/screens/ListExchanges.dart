import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:handofmidas/constants/app_themes.dart';
import 'package:handofmidas/models/AppState.dart';
import 'package:handofmidas/models/PageIndex.dart';
import 'package:handofmidas/screens/AddExchange.dart';
import 'package:handofmidas/screens/AddWallet.dart';
import 'package:handofmidas/widgets/AppBarTime.dart';

import 'package:handofmidas/widgets/ListExchangesPage.dart';

class ListExchangesScreen extends StatefulWidget {
  @override
  _ListExchangesState createState() {
    return _ListExchangesState();
  }
}

class _ListExchangesState extends State<ListExchangesScreen> {
  PageController _pageController;
  PageIndex _pageIndex;
  int _currentPage;

  @override
  void initState() {
    super.initState();

    _currentPage = numberPage - 2;
    _pageController = PageController(initialPage: _currentPage);
  }

  void updateCurrentPage(int currentPage) {
    setState(() {
      _currentPage = currentPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    _pageIndex = PageIndex(context, 1, DateTime.now(), 0);
    return SafeArea(
        child: StoreConnector<AppState, AppState>(
            converter: (store) => store.state,
            builder: (context, state) {
              if (state.wallet == null)
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddWalletScreen()));

              return Scaffold(
                  backgroundColor: Theme.of(context).backgroundColor,
                  appBar: AppBarTime(state.wallet, _pageIndex, _currentPage,
                      _pageController, appBarHeigh * 2),
                  floatingActionButton: FloatingActionButton(
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddExchangeScreen())),
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                      backgroundColor: Theme.of(context).buttonColor),
                  body: PageView.builder(
                      itemCount: numberPage,
                      controller: _pageController,
                      itemBuilder: (context, indexPage) {
                        return ListExchangesPageWidget(
                            _pageIndex.rangeTime(indexPage), state.wallet.id);
                      },
                      onPageChanged: (pageIndex) =>
                          updateCurrentPage(pageIndex)));
            }));
  }
}
