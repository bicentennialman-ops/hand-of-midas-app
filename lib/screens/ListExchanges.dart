import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:handofmidas/models/AppState.dart';

import 'package:handofmidas/widgets/ListExchangesPage.dart';

class ListExchangesScreen extends StatefulWidget {
  @override
  _ListExchangesState createState() {
    return _ListExchangesState();
  }
}

class _ListExchangesState extends State<ListExchangesScreen> {
  PageController _pageController;
  PageView _pageView;
  int _currentPage;

  @override
  void initState() {
    super.initState();

    _currentPage = 2;
    _pageController = PageController(initialPage: _currentPage);
    _pageView = PageView.builder(
        itemCount: 10,
        controller: _pageController,
        itemBuilder: (context, indexPage) {
          return ListExchangesPageWidget(indexPage);
        },
        onPageChanged: (pageIndex) => updateCurrentPage(pageIndex));
  }

  void updateCurrentPage(int currentPage) {
    setState(() {
      _currentPage = currentPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          title: Text('Index: $_currentPage'),
        ),
        body: StoreConnector<AppState, AppState>(
            converter: (store) => store.state,
            builder: (context, state) {
              return _pageView;
            })));
  }
}
