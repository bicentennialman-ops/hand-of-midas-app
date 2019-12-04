import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:handofmidas/localizations.dart';

class CurrencyInputFormatter extends TextInputFormatter {
  final BuildContext context;
  final String code;
  CurrencyInputFormatter(this.context, this.code);
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    double value = double.parse(newValue.text);

    String newText = AppLocalizations.of(context).onlyNumberMoney(value, code);

    return newValue.copyWith(
        text: newText,
        selection: new TextSelection.collapsed(offset: newText.length));
  }
}
