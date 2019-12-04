import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/svg.dart';
import 'package:handofmidas/constants/app_themes.dart';
import 'package:handofmidas/constants/strings.dart';
import 'package:handofmidas/localizations.dart';
import 'package:handofmidas/models/AppState.dart';
import 'package:handofmidas/models/PageIndex.dart';
import 'package:handofmidas/models/Wallet.dart';
import 'package:handofmidas/redux/actions.dart';
import 'package:handofmidas/screens/SelectWallet.dart';
import 'package:handofmidas/utils/index.dart';

class AppBarTime extends StatelessWidget implements PreferredSizeWidget {
  AppBarTime(this.wallet, this.pageIndex, this.currentPage, this.pageController,
      this.height);
  final PageIndex pageIndex;
  final PageController pageController;
  final int currentPage;
  final double height;
  final Wallet wallet;
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
                                Navigator.pop(context);
                              })));
                },
                child: Row(
                  children: <Widget>[
                    Container(
                      width: iconSmallSize,
                      height: iconSmallSize,
                      margin: Layout.mr2,
                      child: SvgPicture.asset(
                          '${Strings.AVATAR_WALLET}/${wallet.avatar}'),
                    ),
                    Text(wallet.name, style: Theme.of(context).textTheme.title)
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
                onPressed: () => pageController.previousPage(
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
                onPressed: () => {},
                child: Row(
                  children: <Widget>[
                    Container(
                      height: iconSmallSize,
                      width: iconSmallSize,
                      margin: Layout.mr1,
                      child: SvgPicture.asset(
                        pageIndex.getIcon(),
                        color: Colors.white,
                      ),
                    ),
                    Text(pageIndex.getTitle(currentPage),
                        style: Theme.of(context).textTheme.title)
                  ],
                ),
              ),
              IconButton(
                onPressed: () => pageController.nextPage(
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

  @override
  Size get preferredSize => Size.fromHeight(height);
}
