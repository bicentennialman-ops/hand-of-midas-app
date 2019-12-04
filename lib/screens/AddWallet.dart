import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/svg.dart';
import 'package:handofmidas/constants/app_themes.dart';
import 'package:handofmidas/constants/strings.dart';
import 'package:handofmidas/database/currency_unit.dart';
import 'package:handofmidas/database/user.dart';
import 'package:handofmidas/localizations.dart';
import 'package:handofmidas/models/AppState.dart';
import 'package:handofmidas/models/CurrencyUnit.dart';
import 'package:handofmidas/database/wallet.dart';
import 'package:handofmidas/models/IconWallet.dart';
import 'package:handofmidas/models/Wallet.dart';
import 'package:handofmidas/models/WalletUser.dart';
import 'package:handofmidas/redux/actions.dart';
import 'package:handofmidas/screens/SelectCurrencyUnit.dart';
import 'package:handofmidas/screens/SelectWalletIcons.dart';
import 'package:handofmidas/services/wallet.dart';
import 'package:handofmidas/utils/index.dart';

import 'ListExchanges.dart';

class AddWalletScreen extends StatefulWidget {
  @override
  _AddWalletScreenState createState() => _AddWalletScreenState();
}

class _AddWalletScreenState extends State<AddWalletScreen> {
  String _nameWallet;
  CurrencyUnit _currencyUnit;
  String _firstMoney;
  String _avatar;
  bool _isAlert;
  bool _isIncremental;

  @override
  void initState() {
    super.initState();
    _isAlert = false;
    _isIncremental = true;
    _firstMoney = "0";
    _avatar = "";
  }

  _selectAvatar(BuildContext context) {
    WalletProvider().getIconWallets().then((icons) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  SelectWalletIconsScreen(icons, (IconWallet icon) {
                    _avatar = icon.icon;
                    Navigator.pop(context);
                  })));
    }).catchError((err) => print(err));
  }

  _selectCurrencyUnit(BuildContext context) {
    CurrencyUnitProvider().getCurrentUnits().then((currencyUnits) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SelectCurrencyUnitScreen((currencyUnit) {
                    _currencyUnit = currencyUnit;
                    Navigator.pop(context);
                  }, currencyUnits)));
    });
  }

  _save(BuildContext context) {
    addWallet(_nameWallet, 1, _avatar, _currencyUnit, _isAlert, _isIncremental,
            double.parse(_firstMoney))
        .then((res) async {
      if (res.statusCode == 200) {
        Map<String, dynamic> walletMap = jsonDecode(res.body);
        List<WalletUser> walletUsers = new List();
        WalletUser walletUser;
        await walletMap["users"].forEach((walletUserMap) async {
          walletUser = WalletUser(
              await UserProvider().getUserBySid(walletUserMap["user"]),
              walletUserMap["role"]);
          walletUser = await WalletProvider().insertWalletUser(walletUser);
          walletUsers.add(walletUser);
        });

        Wallet wallet = await WalletProvider().insertWallet(Wallet(
            null,
            walletMap["_id"],
            _nameWallet,
            walletMap["type"],
            _currencyUnit,
            _avatar,
            await UserProvider().getUserBySid(walletMap["userCreate"]),
            walletUsers,
            walletMap["destionation"],
            walletMap["note"],
            DateTime.parse(walletMap["createDate"]),
            DateTime.parse(walletMap["updateDate"]),
            DateTime.parse(walletMap["startDate"]),
            walletMap["endDate"] != null
                ? DateTime.parse(walletMap["endDate"])
                : null,
            double.parse(_firstMoney),
            null));
        if (wallet != null) {
          await setup("walletId", wallet.id);
          StoreProvider.of<AppState>(context).dispatch(SelectWallet(wallet));
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ListExchangesScreen()));
        }
      } else
        print(res.body);
    }).catchError((err) {
      print(err);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context)
        .textTheme
        .display4
        .copyWith(color: Colors.black, fontWeight: FontWeight.w300);
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: Theme.of(context).backgroundColor,
            appBar: PreferredSize(
              preferredSize: Size(null, appBarHeigh),
              child: Container(
                decoration: BoxDecoration(color: Colors.white),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () => Navigator.of(context).pop(null),
                    ),
                    Text(AppLocalizations.of(context).addWalletTitle,
                        style: Theme.of(context)
                            .textTheme
                            .title
                            .copyWith(color: Colors.black)),
                    FlatButton(
                      onPressed: () => _save(context),
                      child: Text(AppLocalizations.of(context).save,
                          style: Theme.of(context)
                              .textTheme
                              .body1
                              .copyWith(color: Theme.of(context).primaryColor)),
                    )
                  ],
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    margin: Layout.mx5,
                    decoration: BoxDecoration(color: Colors.white),
                    child: Padding(
                      padding: EdgeInsets.all(Layout.p2),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: Layout.mb1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Flexible(
                                  flex: 1,
                                  child: ((_avatar == null) ||
                                          (_avatar.isEmpty))
                                      ? FlatButton(
                                          padding: EdgeInsets.all(0),
                                          onPressed: () =>
                                              _selectAvatar(context),
                                          child: Container(
                                            width: avatarSize,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Container(
                                                  height: avatarSize,
                                                  width: avatarSize,
                                                  margin: Layout.mb1,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          avatarBorderRadius,
                                                      color: AppColors.gray[50],
                                                      border: Border.all(
                                                          color: AppColors
                                                              .gray[100])),
                                                ),
                                                Container(
                                                  height: 1,
                                                  width: avatarSize,
                                                  decoration: BoxDecoration(
                                                      border: Border(
                                                          bottom: BorderSide(
                                                              color: Theme.of(
                                                                      context)
                                                                  .dividerColor))),
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                      : FlatButton(
                                          materialTapTargetSize:
                                              MaterialTapTargetSize.shrinkWrap,
                                          onPressed: () =>
                                              _selectAvatar(context),
                                          child: Container(
                                            height: avatarSize,
                                            width: avatarSize,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    avatarBorderRadius),
                                            child: SvgPicture.asset(
                                                '${Strings.AVATAR_WALLET}/$_avatar'),
                                          ),
                                        ),
                                ),
                                Flexible(
                                  flex: 5,
                                  child: TextField(
                                    onChanged: (value) {
                                      this.setState(() {
                                        _nameWallet = value;
                                      });
                                    },
                                    maxLines: 1,
                                    keyboardType: TextInputType.text,
                                    style: textStyle,
                                    decoration: InputDecoration(
                                        enabledBorder: new UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: AppColors.gray[100],
                                                style: BorderStyle.solid)),
                                        hintText: AppLocalizations.of(context)
                                            .walletName,
                                        hintStyle: textStyle.copyWith(
                                            color: AppColors.gray[50]),
                                        fillColor: Colors.black),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: Layout.mb4,
                            child: Row(
                              children: <Widget>[
                                Container(
                                  height: iconSize,
                                  width: avatarSize,
                                  margin: Layout.mr4,
                                  child: SvgPicture.asset(
                                      '${Strings.ICON}/currency-unit.svg'),
                                ),
                                Flexible(
                                  child: FlatButton(
                                    padding: EdgeInsets.all(0),
                                    onPressed: () {
                                      _selectCurrencyUnit(context);
                                    },
                                    child: Container(
                                      height: avatarSize,
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: AppColors.gray[100],
                                                  style: BorderStyle.solid))),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                            child: _currencyUnit == null
                                                ? Text(
                                                    AppLocalizations.of(context)
                                                        .currencyUnit,
                                                    style: textStyle.copyWith(
                                                        color:
                                                            AppColors.gray[50]))
                                                : Text(
                                                    _currencyUnit.name,
                                                    style: textStyle,
                                                  ),
                                          ),
                                          Container(
                                            height: iconSmallSize,
                                            width: iconSmallSize,
                                            child: SvgPicture.asset(
                                                '${Strings.ICON}/arrow-right.svg'),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: Layout.mb3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  AppLocalizations.of(context).firstMoney,
                                  style: Theme.of(context)
                                      .textTheme
                                      .display4
                                      .copyWith(
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black),
                                ),
                                Row(
                                  children: <Widget>[
                                    SizedBox(
                                      width: iconSize,
                                    ),
                                    Flexible(
                                      child: TextField(
                                        onChanged: (value) {
                                          this.setState(() {
                                            _firstMoney = value;
                                          });
                                        },
                                        maxLines: 1,
                                        keyboardType: TextInputType.number,
                                        style: textStyle,
                                        decoration: InputDecoration(
                                            contentPadding:
                                                EdgeInsets.all(Layout.p2),
                                            enabledBorder:
                                                new UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color:
                                                            AppColors.gray[100],
                                                        style:
                                                            BorderStyle.solid)),
                                            hintText:
                                                AppLocalizations.of(context)
                                                    .walletName,
                                            hintStyle: textStyle.copyWith(
                                                color: AppColors.gray[50]),
                                            fillColor: Colors.black),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(color: Colors.white),
                    child: Padding(
                      padding: EdgeInsets.all(Layout.p2),
                      child: Column(
                        children: <Widget>[
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(AppLocalizations.of(context).onAlert,
                                        style: Theme.of(context)
                                            .textTheme
                                            .display4),
                                    Text(
                                      AppLocalizations.of(context)
                                          .onAlertDescription,
                                      style:
                                          Theme.of(context).textTheme.subtitle,
                                    )
                                  ],
                                ),
                                Switch(
                                  value: _isAlert == null ? true : _isAlert,
                                  onChanged: (value) {
                                    setState(() {
                                      _isAlert = value;
                                    });
                                  },
                                  activeColor: Theme.of(context).primaryColor,
                                )
                              ]),
                          SizedBox(
                            height: Layout.m2,
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                        AppLocalizations.of(context)
                                            .doNotSumToTotal,
                                        style: Theme.of(context)
                                            .textTheme
                                            .display4),
                                    Text(
                                      AppLocalizations.of(context)
                                          .doNotSumToTotal,
                                      style:
                                          Theme.of(context).textTheme.subtitle,
                                    )
                                  ],
                                ),
                                Switch(
                                  value: _isIncremental == null
                                      ? false
                                      : _isIncremental,
                                  onChanged: (value) {
                                    setState(() {
                                      _isIncremental = value;
                                    });
                                  },
                                  activeColor: Theme.of(context).primaryColor,
                                )
                              ]),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
