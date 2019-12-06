import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:handofmidas/constants/app_themes.dart';
import 'package:handofmidas/models/AppState.dart';
import 'package:handofmidas/models/PageIndex.dart';
import 'package:handofmidas/models/TimeType.dart';
import 'package:handofmidas/screens/AddExchange.dart';
import 'package:handofmidas/screens/AddWallet.dart';
import 'package:handofmidas/utils/index.dart';
import 'package:handofmidas/widgets/AppBarTime.dart';

import 'package:handofmidas/widgets/ListExchangesPage.dart';

class ListExchangesScreen extends StatefulWidget {
  final TimeType timeType;
  ListExchangesScreen(this.timeType);
  @override
  _ListExchangesState createState() {
    return _ListExchangesState();
  }
}

class _ListExchangesState extends State<ListExchangesScreen> {
  PageController _pageController;
  PageIndex _pageIndex;
  int _currentPage;
  String _keyPageView;

  @override
  void initState() {
    super.initState();

    _pageIndex = PageIndex(context, widget.timeType.type,
        widget.timeType.rootDate, widget.timeType.rangeDate);
    _currentPage = _pageIndex.getNumberPage() - 2;
    _pageController = PageController(initialPage: _currentPage);
    _keyPageView = DateTime.now().toString();
  }

  void updateCurrentPage(int currentPage) {
    setState(() {
      _currentPage = currentPage;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                      _pageController, appBarHeigh * 2, (pageIndex) {
                    setState(() {
                      _pageIndex = pageIndex;
                    });
                  }, () {
                    _currentPage = _pageIndex.getNumberPage() - 2;
                    _pageController = PageController(initialPage: _currentPage);
                    _keyPageView = DateTime.now().toString();
                  }),
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
                      key: Key(_keyPageView),
                      itemCount: _pageIndex.getNumberPage(),
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
