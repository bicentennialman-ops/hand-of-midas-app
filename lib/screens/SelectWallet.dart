import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:handofmidas/constants/app_themes.dart';
import 'package:handofmidas/constants/strings.dart';
import 'package:handofmidas/database/exchange.dart';
import 'package:handofmidas/database/wallet.dart';
import 'package:handofmidas/models/Wallet.dart';
import 'package:handofmidas/screens/AddWallet.dart';

import '../localizations.dart';

class SelectWalletScreen extends StatefulWidget {
  final selectWallet;
  SelectWalletScreen(this.selectWallet);
  @override
  _SelectWalletScreenState createState() =>
      _SelectWalletScreenState(selectWallet);
}

class _SelectWalletScreenState extends State<SelectWalletScreen> {
  List<Wallet> _wallets;
  var _selectWallet;
  _SelectWalletScreenState(this._selectWallet) {
    WalletProvider().getWallets().then((wls) async {
      List<Wallet> wallets = new List();
      for (var wl in wls) {
        wl.money =
            wl.firstMoney + await ExchangeProvider().getTotalMoney(wl.id);
        wallets.add(wl);
      }
      setState(() {
        _wallets = wallets;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: PreferredSize(
          preferredSize: Size(null, appBarHeigh),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                BackButton(),
                Text(AppLocalizations.of(context).selectWallet,
                    style: Theme.of(context)
                        .textTheme
                        .title
                        .copyWith(color: Colors.black)),
                SizedBox(
                  width: iconSize,
                )
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
              Container(
                margin: EdgeInsets.all(Layout.p1),
                child: Text(
                  AppLocalizations.of(context).personalWallet,
                  style: Theme.of(context).textTheme.subtitle,
                ),
              ),
              Container(
                  decoration: BoxDecoration(color: Colors.white),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: _wallets != null
                          ? _wallets.map((wallet) {
                              return (FlatButton(
                                padding: EdgeInsets.all(Layout.p2),
                                onPressed: () => _selectWallet(wallet),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      height: iconSize,
                                      width: iconSize,
                                      margin: Layout.mr2,
                                      child: SvgPicture.asset(
                                          "${Strings.AVATAR_WALLET}/${wallet.avatar}"),
                                    ),
                                    Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(wallet.name,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .body1),
                                          Text(
                                            AppLocalizations.of(context).money(
                                                wallet.money,
                                                wallet.currencyUnit.code),
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle,
                                          ),
                                        ])
                                  ],
                                ),
                              ));
                            }).toList()
                          : []))
            ])),
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          backgroundColor: AppColors.blue[50],
          onPressed: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddWalletScreen())),
        ),
      ),
    );
  }
}
