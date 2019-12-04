import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:handofmidas/constants/app_themes.dart';
import 'package:handofmidas/constants/strings.dart';
import 'package:handofmidas/localizations.dart';
import 'package:handofmidas/models/IconWallet.dart';

class SelectWalletIconsScreen extends StatelessWidget {
  final List<IconWallet> iconWallets;
  final selectIcon;
  SelectWalletIconsScreen(this.iconWallets, this.selectIcon);

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
                Text(AppLocalizations.of(context).selectIcon,
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
        body: GridView.count(
          crossAxisCount: 4,
          children: iconWallets.map((icon) {
            return Container(
              height: iconSize,
              width: iconSize,
              child: IconButton(
                onPressed: () => selectIcon(icon),
                icon: SvgPicture.asset('${Strings.AVATAR_WALLET}/${icon.icon}'),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
