import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/svg.dart';
import 'package:handofmidas/constants/app_themes.dart';
import 'package:handofmidas/constants/strings.dart';
import 'package:handofmidas/database/user.dart';
import 'package:handofmidas/localizations.dart';
import 'package:handofmidas/models/AppState.dart';
import 'package:handofmidas/models/User.dart';
import 'package:handofmidas/redux/actions.dart';
import 'package:handofmidas/screens/AddWallet.dart';
import 'package:handofmidas/screens/ListExchanges.dart';
import 'package:handofmidas/services/user.dart' as userService;
import 'package:handofmidas/utils/index.dart';

class LoginScreen extends StatefulWidget {
  final String token;

  LoginScreen({Key key, this.token}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _username;
  String _password;

  void login(BuildContext context, AppState state) {
    userService.login(_username, _password).then((res) {
      if (res.statusCode == 200) {
        String token = jsonDecode(res.body)["token"];
        StoreProvider.of<AppState>(context).dispatch(Login(token));
        userService.storage.write(key: "token", value: token);
        Map<String, dynamic> setting = new Map();
        if (state.firstLoad) {
          setting["firstLoad"] = false;
        }
        userService.storage.write(key: "setting", value: jsonEncode(setting));
        userService.getUserInfor().then((res) {
          if (res.statusCode == 200) {
            User user = User.fromMap(jsonDecode(res.body));
            UserProvider().insertUser(user);
          }
        });

        if (state.wallet == null)
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddWalletScreen()));
        else
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ListExchangesScreen(state.timeType)));
      } else {
        showAlertDialog(context);
      }
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(AppLocalizations.of(context).error),
      content: Text(AppLocalizations.of(context).alertUnauthorized),
      actions: [
        cancelButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StoreConnector<AppState, AppState>(
          converter: (store) => store.state,
          builder: (context, state) {
            return Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomLeft,
                    stops: stopsColorLoginScreen,
                    colors: gradientColorLoginScreen),
              ),
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: logoSize,
                        width: logoSize,
                        child: ClipRRect(
                          borderRadius: logoBorderRadius,
                          child: SvgPicture.asset('${Strings.ASSET}/logo.svg'),
                        ),
                        margin: Layout.mb4,
                      ),
                      LoginInputForm(
                          '${Strings.ICON}/user.svg',
                          TextInputType.emailAddress,
                          AppLocalizations.of(context).username,
                          false, (value) {
                        setState(() {
                          _username = value;
                        });
                      }),
                      LoginInputForm(
                          '${Strings.ICON}/key.svg',
                          TextInputType.visiblePassword,
                          AppLocalizations.of(context).password,
                          true, (value) {
                        setState(() {
                          _password = value;
                        });
                        ;
                      }),
                      RaisedButton(
                          padding: EdgeInsets.all(Layout.p2),
                          shape: RoundedRectangleBorder(
                              borderRadius: buttonBorderRadius,
                              side: BorderSide(color: AppColors.green[700])),
                          onPressed: () => login(context, state),
                          color: AppColors.green[700],
                          textColor: Colors.white,
                          child: Container(
                            child: Text(
                              AppLocalizations.of(context).login,
                              style: Theme.of(context)
                                  .textTheme
                                  .display3
                                  .copyWith(color: Colors.white),
                            ),
                          )),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}

class LoginInputForm extends StatelessWidget {
  final String assetIcon;
  final TextInputType type;
  final String placeholder;
  final bool isSecurity;
  final onChanged;

  LoginInputForm(this.assetIcon, this.type, this.placeholder, this.isSecurity,
      this.onChanged);

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context)
        .textTheme
        .display4
        .copyWith(color: Colors.white, fontWeight: FontWeight.w300);
    return Container(
      margin: EdgeInsets.only(top: Layout.m2, bottom: Layout.m2),
      child: Row(
        children: <Widget>[
          Container(
            height: iconSize,
            width: iconSize,
            margin: Layout.mr2,
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              child: SvgPicture.asset(assetIcon),
            ),
          ),
          SizedBox(height: 45.0),
          Flexible(
            child: Container(
              decoration: new BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: TextField(
                onChanged: onChanged,
                maxLines: 1,
                keyboardType: type,
                style: textStyle,
                obscureText: isSecurity,
                decoration: InputDecoration(
                    enabledBorder: new UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.white, style: BorderStyle.solid)),
                    hintText: placeholder,
                    hintStyle: textStyle,
                    fillColor: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
