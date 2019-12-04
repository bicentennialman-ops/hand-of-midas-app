import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/svg.dart';
import 'package:handofmidas/constants/app_themes.dart';
import 'package:handofmidas/constants/strings.dart';
import 'package:handofmidas/models/AppState.dart';
import 'package:handofmidas/models/Category.dart';
import 'package:handofmidas/models/Person.dart';
import 'package:handofmidas/models/Position.dart';
import 'package:handofmidas/models/Wallet.dart';
import 'package:handofmidas/redux/actions.dart';
import 'package:handofmidas/screens/SelectCategory.dart';
import 'package:handofmidas/screens/SelectWallet.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import '../localizations.dart';

class AddExchangeScreen extends StatefulWidget {
  @override
  _AddExchangeScreenState createState() => _AddExchangeScreenState();
}

class _AddExchangeScreenState extends State<AddExchangeScreen> {
  double _money;
  Category _category;
  String _note;
  DateTime _date = DateTime.now();
  Wallet _wallet;
  Person _withPerson;
  Position _position;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (context, state) {
          return Scaffold(
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
                    Text(AppLocalizations.of(context).addExchange,
                        style: Theme.of(context)
                            .textTheme
                            .title
                            .copyWith(color: Colors.black)),
                    FlatButton(
                      onPressed: () {},
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
                    margin: Layout.mt3,
                    decoration: BoxDecoration(color: Colors.white),
                    child: Padding(
                      padding: EdgeInsets.all(Layout.p2),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            AppLocalizations.of(context).amount,
                            style: Theme.of(context).textTheme.body1,
                          ),
                          Row(children: <Widget>[
                            Flexible(
                              child: TextField(
                                onChanged: (value) {
                                  this.setState(() {
                                    _money = double.parse(value);
                                  });
                                },
                                maxLines: 1,
                                keyboardType: TextInputType.number,
                                style: Theme.of(context)
                                    .textTheme
                                    .display2
                                    .copyWith(color: AppColors.blue[50]),
                                textAlign: TextAlign.right,
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(Layout.p2),
                                    enabledBorder: new UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: AppColors.gray[100],
                                            style: BorderStyle.solid)),
                                    hintText:
                                        AppLocalizations.of(context).amount,
                                    hintStyle: Theme.of(context)
                                        .textTheme
                                        .body1
                                        .copyWith(color: AppColors.gray[50]),
                                    fillColor: Colors.black),
                              ),
                            ),
                            Text(
                              state.wallet.currencyUnit.character,
                              style: Theme.of(context)
                                  .textTheme
                                  .display2
                                  .copyWith(color: AppColors.gray[100]),
                            )
                          ]),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: Layout.mt3,
                    decoration: BoxDecoration(color: Colors.white),
                    child: Column(
                      children: <Widget>[
                        FlatButton(
                          padding: EdgeInsets.all(Layout.p2),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        SelectCategoryScreen((category) {
                                          _category = category;
                                          Navigator.pop(context);
                                        })));
                          },
                          child: (_category == null)
                              ? Row(children: <Widget>[
                                  Container(
                                    height: iconSize,
                                    width: iconSize,
                                    margin: Layout.mr2,
                                    child: SvgPicture.asset(
                                        "${Strings.ICON}/question.svg"),
                                  ),
                                  Flexible(
                                    child: Container(
                                        padding: EdgeInsets.only(
                                            top: Layout.p2, bottom: Layout.p2),
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    color: AppColors.gray[50],
                                                    width: 1))),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              AppLocalizations.of(context)
                                                  .selectCategory,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .body1
                                                  .copyWith(
                                                      color:
                                                          AppColors.gray[50]),
                                            ),
                                            Container(
                                              height: iconMiniSize,
                                              width: iconMiniSize,
                                              child: SvgPicture.asset(
                                                  "${Strings.ICON}/arrow-right.svg"),
                                            )
                                          ],
                                        )),
                                  ),
                                ])
                              : Row(
                                  children: <Widget>[],
                                ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(Layout.p2),
                          child: Row(
                            children: <Widget>[
                              Container(
                                height: iconSize,
                                width: iconSize,
                                margin: Layout.mr1,
                                child: SvgPicture.asset(
                                    "${Strings.ICON}/note.svg"),
                              ),
                              Flexible(
                                child: TextField(
                                  onChanged: (value) {
                                    this.setState(() {
                                      _note = value;
                                    });
                                  },
                                  maxLines: 1,
                                  keyboardType: TextInputType.text,
                                  style: Theme.of(context).textTheme.display4,
                                  decoration: InputDecoration(
                                      enabledBorder: new UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppColors.gray[50],
                                              style: BorderStyle.solid)),
                                      hintText:
                                          AppLocalizations.of(context).note,
                                      contentPadding: EdgeInsets.all(Layout.p2),
                                      hintStyle: Theme.of(context)
                                          .textTheme
                                          .body1
                                          .copyWith(color: AppColors.gray[50]),
                                      fillColor: Colors.black),
                                ),
                              )
                            ],
                          ),
                        ),
                        FlatButton(
                          onPressed: () {
                            DatePicker.showDateTimePicker(context,
                                locale: LocaleType.en,
                                showTitleActions: true, onConfirm: (date) {
                              this.setState(() {
                                _date = date;
                              });
                            }, currentTime: _date);
                          },
                          padding: EdgeInsets.all(Layout.p2),
                          child: Row(
                            children: <Widget>[
                              Container(
                                height: iconSize,
                                width: iconSize,
                                margin: Layout.mr2,
                                child: SvgPicture.asset(
                                    "${Strings.ICON}/calendar.svg"),
                              ),
                              Flexible(
                                child: Container(
                                  padding: EdgeInsets.only(
                                      top: Layout.p2, bottom: Layout.p2),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: AppColors.gray[50],
                                              width: 1))),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        AppLocalizations.of(context)
                                            .dateMonthYear(_date),
                                        style:
                                            Theme.of(context).textTheme.body1,
                                      ),
                                      Text(
                                        AppLocalizations.of(context)
                                            .hours(_date),
                                        style:
                                            Theme.of(context).textTheme.body1,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        FlatButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        SelectWalletScreen((wallet) {
                                          StoreProvider.of<AppState>(context)
                                              .dispatch(SelectWallet(wallet));
                                          Navigator.pop(context);
                                        })));
                          },
                          padding: EdgeInsets.all(Layout.p2),
                          child: Row(
                            children: <Widget>[
                              Container(
                                height: iconSize,
                                width: iconSize,
                                margin: Layout.mr2,
                                child: SvgPicture.asset(
                                    "${Strings.AVATAR_WALLET}/${state.wallet.avatar}"),
                              ),
                              Flexible(
                                child: Container(
                                  padding: EdgeInsets.only(
                                      top: Layout.p2, bottom: Layout.p2),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: AppColors.gray[50],
                                              width: 1))),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        state.wallet.name,
                                        style:
                                            Theme.of(context).textTheme.body1,
                                      ),
                                      Container(
                                        height: iconMiniSize,
                                        width: iconMiniSize,
                                        child: SvgPicture.asset(
                                            "${Strings.ICON}/arrow-right.svg"),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
