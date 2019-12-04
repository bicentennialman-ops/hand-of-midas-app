import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'l10n/messages_all.dart';

class AppLocalizations {
  AppLocalizations(this.localeName, this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static Future<AppLocalizations> load(Locale locale) {
    Intl.defaultLocale = locale.languageCode;
    final String name =
        locale.countryCode.isEmpty ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((_) {
      return AppLocalizations(localeName, locale);
    });
  }

  final String localeName;
  final Locale locale;

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

  String hours(DateTime date) {
    Intl.defaultLocale = locale.languageCode;
    String dateFormat = new DateFormat('HH:mm').format(date);
    return dateFormat;
  }

  String get username =>
      Intl.message("Username", name: "username", locale: localeName);
  String get password =>
      Intl.message("Password", name: "password", locale: localeName);
  String get today => Intl.message("To day", name: "today", locale: localeName);
  String get yesterday =>
      Intl.message("Yesteray", name: "yesterday", locale: localeName);
  String get thisWeek =>
      Intl.message("This week", name: "thisWeek", locale: localeName);
  String get lastWeek =>
      Intl.message("Last week", name: "lastWeek", locale: localeName);
  String get thisMonth => Intl.message("This month", name: "thisMonth");
  String get lastMonth => Intl.message("Last month", name: "lastMonth");
  String get thisYear => Intl.message("This year", name: "thisYear");
  String get lastYear => Intl.message("Last year", name: "lastYear");
  String get formatDateMonthYear =>
      Intl.message("dd/MM/yyyy", name: "formatDateMonthYear");
  String get formatMonthYear =>
      Intl.message("MMMM, yyyy", name: "formatMonthYear");
  String get future => Intl.message("Future", name: "future");
  String get exchangesTitle =>
      Intl.message("Exchanges", name: "exchangesTitle");
  String get addWalletTitle =>
      Intl.message("Add wallet", name: "addWalletTitle");
  String get save => Intl.message("Save", name: "save");
  String get walletName => Intl.message("Wallet name", name: "walletName");
  String get currencyUnit =>
      Intl.message("Currency unit", name: "currencyUnit");
  String get firstMoney => Intl.message("First money", name: "firstMoney");
  String get onAlert => Intl.message("On alert", name: "onAlert");
  String get onAlertDescription =>
      Intl.message("On alert when has new exchanges",
          name: "onAlertDescription");
  String get doNotSumToTotal =>
      Intl.message("Don't sum to total", name: "doNotSumToTotal");
  String get selectIcon => Intl.message("Select icon", name: "selectIcon");
  String get selectWallet =>
      Intl.message("Select wallet", name: "selectWallet");
  String get selectCategory =>
      Intl.message("Select category", name: "selectCategory");
  String get addExchange => Intl.message('Add Exchange', name: 'addExchange');
  String get personalWallet =>
      Intl.message("Personal Wallet", name: "personalWallet");
  String get amount => Intl.message("Amount", name: "amount");
  String get note => Intl.message("Note", name: "note");
  String rangeDate(DateTime from, DateTime to) {
    DateFormat format = DateFormat(formatDateMonthYear);
    return '${format.format(from)} - ${format.format(to)}';
  }

  String get debtLoan => Intl.message("Debt & Loan", name: "debtLoan");
  String get expense => Intl.message("Expense", name: "expense");
  String get income => Intl.message("Income", name: "income");

  String month(DateTime time) {
    return DateFormat(formatMonthYear).format(time);
  }

  String onlyYear(DateTime time) {
    return time.year.toString();
  }

  String get error => Intl.message("Error", name: "error");
  String get alertUnauthorized =>
      Intl.message("Username/password is incorrect!",
          name: "alertUnauthorized");
  String get login => Intl.message("Login", name: "login");
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
  bool isSupported(Locale locale) => ['en', 'vi'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(
        AppLocalizations(locale.languageCode, locale));
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
