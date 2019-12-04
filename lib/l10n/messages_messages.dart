// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a messages locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'messages';

  static m0(count) => "${count} exchanges";

  static m1(name) => "Hello ${name}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "addWalletTitle" : MessageLookupByLibrary.simpleMessage("Add wallet"),
    "alertUnauthorized" : MessageLookupByLibrary.simpleMessage("Username/password is incorrect!"),
    "countExchanges" : m0,
    "currencyUnit" : MessageLookupByLibrary.simpleMessage("Currency unit"),
    "doNotSumToTotal" : MessageLookupByLibrary.simpleMessage("Don\'t sum to total"),
    "error" : MessageLookupByLibrary.simpleMessage("Error"),
    "exchangesTitle" : MessageLookupByLibrary.simpleMessage("Exchanges"),
    "firstMoney" : MessageLookupByLibrary.simpleMessage("First money"),
    "formatDateMonthYear" : MessageLookupByLibrary.simpleMessage("dd/MM/yyyy"),
    "formatMonthYear" : MessageLookupByLibrary.simpleMessage("MMMM, yyyy"),
    "future" : MessageLookupByLibrary.simpleMessage("Future"),
    "hello" : m1,
    "lastMonth" : MessageLookupByLibrary.simpleMessage("Last month"),
    "lastWeek" : MessageLookupByLibrary.simpleMessage("Last week"),
    "lastYear" : MessageLookupByLibrary.simpleMessage("Last year"),
    "login" : MessageLookupByLibrary.simpleMessage("Login"),
    "onAlert" : MessageLookupByLibrary.simpleMessage("On alert"),
    "onAlertDescription" : MessageLookupByLibrary.simpleMessage("On alert when has new exchanges"),
    "password" : MessageLookupByLibrary.simpleMessage("Password"),
    "save" : MessageLookupByLibrary.simpleMessage("Save"),
    "selectIcon" : MessageLookupByLibrary.simpleMessage("Select icon"),
    "thisMonth" : MessageLookupByLibrary.simpleMessage("This month"),
    "thisWeek" : MessageLookupByLibrary.simpleMessage("This week"),
    "thisYear" : MessageLookupByLibrary.simpleMessage("This year"),
    "title" : MessageLookupByLibrary.simpleMessage("Hello world App"),
    "today" : MessageLookupByLibrary.simpleMessage("To day"),
    "username" : MessageLookupByLibrary.simpleMessage("Username"),
    "walletName" : MessageLookupByLibrary.simpleMessage("Wallet name"),
    "walletNameDefault" : MessageLookupByLibrary.simpleMessage("Cash"),
    "yesterday" : MessageLookupByLibrary.simpleMessage("Yesteray")
  };
}
