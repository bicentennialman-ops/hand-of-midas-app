import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/svg.dart';
import 'package:handofmidas/constants/app_themes.dart';
import 'package:handofmidas/constants/strings.dart';
import 'package:handofmidas/database/exchange.dart';
import 'package:handofmidas/localizations.dart';
import 'package:handofmidas/models/AppState.dart';
import 'package:handofmidas/models/PageIndex.dart';
import 'package:handofmidas/models/TimeType.dart';
import 'package:handofmidas/models/Wallet.dart';
import 'package:handofmidas/redux/actions.dart';
import 'package:handofmidas/screens/SelectWallet.dart';
import 'package:handofmidas/utils/index.dart';
import 'package:handofmidas/widgets/SelectTypeTime.dart';

class AppBarTime extends StatefulWidget implements PreferredSizeWidget {
  AppBarTime(this.wallet, this.pageIndex, this.currentPage, this.pageController,
      this.height, this.changePageIndex, this.change);
  final PageIndex pageIndex;
  final PageController pageController;
  final int currentPage;
  final double height;
  final Wallet wallet;
  final change;
  final changePageIndex;

  @override
  _AppBarTimeState createState() => _AppBarTimeState();
  @override
  Size get preferredSize => Size.fromHeight(height);
}

class _AppBarTimeState extends State<AppBarTime> {
  double _totalMoney = 0;

  PageIndex _pageIndex;
  @override
  void initState() {
    super.initState();
    _pageIndex = widget.pageIndex;
    ExchangeProvider().getTotalMoney(widget.wallet.id).then((money) {
      this.setState(() {
        _totalMoney = money + widget.wallet.firstMoney;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Theme.of(context).primaryColor),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              BackButton(color: Colors.white),
              FlatButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SelectWalletScreen((wallet) {
                                StoreProvider.of<AppState>(context)
                                    .dispatch(SelectWallet(wallet));
                                setup("walletId", wallet.id);
                                ExchangeProvider()
                                    .getTotalMoney(wallet.id)
                                    .then((money) {
                                  this.setState(() {
                                    _totalMoney = money + wallet.firstMoney;
                                  });
                                });
                                widget.change();
                                Navigator.pop(context);
                              })));
                },
                child: Row(
                  children: <Widget>[
                    Container(
                      width: iconSmallSize,
                      height: iconSmallSize,
                      child: SvgPicture.asset(
                          '${Strings.AVATAR_WALLET}/${widget.wallet.avatar}'),
                    ),
                    Icon(Icons.arrow_drop_down),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(widget.wallet.name,
                            style: Theme.of(context)
                                .textTheme
                                .body1
                                .copyWith(color: Colors.white)),
                        Text(
                          AppLocalizations.of(context).money(
                              _totalMoney, widget.wallet.currencyUnit.code),
                          style: Theme.of(context)
                              .textTheme
                              .body1
                              .copyWith(color: Colors.white),
                        )
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(width: iconSize)
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                onPressed: () => widget.pageController.previousPage(
                    duration: Duration(milliseconds: 200),
                    curve: Curves.linear),
                icon: Container(
                  height: iconSmallSize,
                  width: iconSmallSize,
                  child: SvgPicture.asset(
                    '${Strings.ICON}/arrow-left.svg',
                    color: Colors.white,
                  ),
                ),
              ),
              FlatButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return SelectTypeTimeDialog(
                            (type, rootDate, rangeDate) {
                          this.setState(() {
                            _pageIndex.type = type;
                            if (rootDate != null)
                              _pageIndex.rootDate = rootDate;
                            if (rangeDate != null)
                              _pageIndex.rangeDate = rangeDate;
                            widget.changePageIndex(_pageIndex);
                            TimeType timeType =
                                TimeType(type, rootDate, rangeDate);
                            StoreProvider.of<AppState>(context)
                                .dispatch(ChangeTimeType(timeType));
                            setup("timeType", timeType.toMap());
                            widget.change();
                          });
                          Navigator.pop(context);
                        });
                      });
                },
                child: Row(
                  children: <Widget>[
                    Container(
                      height:
                          _pageIndex.isInfinity() ? iconSize : iconSmallSize,
                      width: _pageIndex.isInfinity() ? iconSize : iconSmallSize,
                      margin: Layout.mr1,
                      child: SvgPicture.asset(
                        _pageIndex.getIcon(),
                        color: Colors.white,
                      ),
                    ),
                    Text(_pageIndex.getTitle(widget.currentPage),
                        style: Theme.of(context).textTheme.title),
                  ],
                ),
              ),
              IconButton(
                onPressed: () => widget.pageController.nextPage(
                    duration: Duration(milliseconds: 200),
                    curve: Curves.linear),
                icon: Container(
                  height: iconSmallSize,
                  width: iconSmallSize,
                  child: SvgPicture.asset('${Strings.ICON}/arrow-right.svg',
                      color: Colors.white),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
