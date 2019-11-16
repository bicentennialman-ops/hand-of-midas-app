import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'l10n/messages_all.dart';

class AppLocalizations {
  Locale locale;

  AppLocalizations(Locale locale) {
    this.locale = locale;
  }

  static Future<AppLocalizations> load(Locale locale) {
    final String name =
        locale.countryCode == null ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((bool _) {
      Intl.defaultLocale = localeName;
      return new AppLocalizations(locale);
    });
  }

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static Map<String, Map<String, String>> _categoryName = {
    'vi': {
      'debt': 'Vay',
      'water': 'Nước',
      'bill-utilities': 'Hóa đơn & Tiện ích',
    },
    'en': {
      'debt': 'Debt',
      'water': 'Water',
      'bill-utilities': 'Bills & Utilities'
    },
  };

  static Map<String, Map<String, dynamic>> _currencyUnit = {
    "VND": {
      "_id": "5dc14f7c5fb4cb0c53099cbf",
      "name": "Việt Nam đồng",
      "code": "VND",
      "character": "₫",
      "avatar": "vietnam.svg",
      "format": "#,###",
      "decimalSeparator": ".",
      "groupingSeparator": ",",
    },
    "USD": {
      "_id": "5dc7f08d214b4e638433296f",
      "name": "Dola",
      "code": "USD",
      "avatar": "united-states.svg",
      "character": "\$",
      "format": "#,##0.00",
      "decimalSeparator": ",",
      "groupingSeparator": ".",
    }
  };

  String get title {
    return Intl.message('Hello world App',
        name: 'title', desc: 'The application title');
  }

  hello(String name) =>
      Intl.message('Hello $name', args: [name], name: 'hello');

  String monthYearDay(DateTime date) {
    Intl.defaultLocale = locale.languageCode;
    String dateFormat = new DateFormat('MMMM, yyyy, EEEE').format(date);
    return dateFormat;
  }

  String dateMonthYear(DateTime date) {
    Intl.defaultLocale = locale.languageCode;
    String dateFormat = new DateFormat('dd MMMM yyyy').format(date);
    return dateFormat;
  }

  String get userName => Intl.message("Username");
  String get password => Intl.message("Password");
  String get toDay => Intl.message("To day");
  String get yesterday => Intl.message("Yesteray");
  String get thisWeek => Intl.message("This week");
  String get lastWeek => Intl.message("Last week");
  String get thisMonth => Intl.message("This month");
  String get lastMonth => Intl.message("Last month");
  String get thisYear => Intl.message("This year");
  String get lastYear => Intl.message("Last year");

  String get error => Intl.message("Error");
  String get alertUnauthorized =>
      Intl.message("Username/password is incorrect!");
  String get login => Intl.message("Login");
  categoryName(String code) => _categoryName[locale.languageCode][code];
  walletNameDefault() => Intl.message('Cash', name: 'walletNameDefault');
  countExchanges(int count) =>
      Intl.message('$count exchanges', args: [count], name: 'countExchanges');
  String money(double money, String code) {
    final currentUnit = _currencyUnit[code];
    final formatMoney = new NumberFormat(currentUnit['format']);
    return '${formatMoney.format(money).replaceAll('.', currentUnit['groupingSeparator']).replaceAll(',', currentUnit['decimalSeparator'])} ${currentUnit['character']}';
  }
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'vi'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(AppLocalizations(locale));
  }

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalizations> old) {
    return false;
  }
}
