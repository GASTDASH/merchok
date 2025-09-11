// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `All`
  String get all {
    return Intl.message('All', name: 'all', desc: '', args: []);
  }

  /// `Search`
  String get search {
    return Intl.message('Search', name: 'search', desc: '', args: []);
  }

  /// `Description...`
  String get description {
    return Intl.message(
      'Description...',
      name: 'description',
      desc: '',
      args: [],
    );
  }

  /// `Merch name`
  String get merchDefaultName {
    return Intl.message(
      'Merch name',
      name: 'merchDefaultName',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message('Save', name: 'save', desc: '', args: []);
  }

  /// `Price`
  String get price {
    return Intl.message('Price', name: 'price', desc: '', args: []);
  }

  /// `Add`
  String get add {
    return Intl.message('Add', name: 'add', desc: '', args: []);
  }

  /// `Import`
  String get import {
    return Intl.message('Import', name: 'import', desc: '', args: []);
  }

  /// `Purchase Price`
  String get purchasePrice {
    return Intl.message(
      'Purchase Price',
      name: 'purchasePrice',
      desc: '',
      args: [],
    );
  }

  /// `Where to import from?`
  String get whereToImportFrom {
    return Intl.message(
      'Where to import from?',
      name: 'whereToImportFrom',
      desc: '',
      args: [],
    );
  }

  /// `From Excel`
  String get fromExcel {
    return Intl.message('From Excel', name: 'fromExcel', desc: '', args: []);
  }

  /// `From CSV`
  String get fromCSV {
    return Intl.message('From CSV', name: 'fromCSV', desc: '', args: []);
  }

  /// `(not available yet)`
  String get notAvailableYet {
    return Intl.message(
      '(not available yet)',
      name: 'notAvailableYet',
      desc: '',
      args: [],
    );
  }

  /// `(recommended)`
  String get recommended {
    return Intl.message(
      '(recommended)',
      name: 'recommended',
      desc: '',
      args: [],
    );
  }

  /// `Festivals`
  String get festivals {
    return Intl.message('Festivals', name: 'festivals', desc: '', args: []);
  }

  /// `Event Date`
  String get eventDate {
    return Intl.message('Event Date', name: 'eventDate', desc: '', args: []);
  }

  /// `Cart is empty`
  String get emptyCart {
    return Intl.message('Cart is empty', name: 'emptyCart', desc: '', args: []);
  }

  /// `Total:`
  String get total {
    return Intl.message('Total:', name: 'total', desc: '', args: []);
  }

  /// `Checkout`
  String get checkout {
    return Intl.message('Checkout', name: 'checkout', desc: '', args: []);
  }

  /// `Receipt from `
  String get receiptFrom {
    return Intl.message(
      'Receipt from ',
      name: 'receiptFrom',
      desc: '',
      args: [],
    );
  }

  /// `General sales statistics`
  String get generalSalesStatistics {
    return Intl.message(
      'General sales statistics',
      name: 'generalSalesStatistics',
      desc: '',
      args: [],
    );
  }

  /// `Popular merch`
  String get popularMerch {
    return Intl.message(
      'Popular merch',
      name: 'popularMerch',
      desc: '',
      args: [],
    );
  }

  /// `History of festivals`
  String get historyOfFestivals {
    return Intl.message(
      'History of festivals',
      name: 'historyOfFestivals',
      desc: '',
      args: [],
    );
  }

  /// `Average receipt`
  String get averageReceipt {
    return Intl.message(
      'Average receipt',
      name: 'averageReceipt',
      desc: '',
      args: [],
    );
  }

  /// `Customer preferences`
  String get customerPreferences {
    return Intl.message(
      'Customer preferences',
      name: 'customerPreferences',
      desc: '',
      args: [],
    );
  }

  /// `Profit`
  String get profit {
    return Intl.message('Profit', name: 'profit', desc: '', args: []);
  }

  /// `Theme`
  String get theme {
    return Intl.message('Theme', name: 'theme', desc: '', args: []);
  }

  /// `Change app theme`
  String get themeDescription {
    return Intl.message(
      'Change app theme',
      name: 'themeDescription',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message('Language', name: 'language', desc: '', args: []);
  }

  /// `Change regional settings`
  String get languageDescription {
    return Intl.message(
      'Change regional settings',
      name: 'languageDescription',
      desc: '',
      args: [],
    );
  }

  /// `Data export`
  String get dataExport {
    return Intl.message('Data export', name: 'dataExport', desc: '', args: []);
  }

  /// `Export data to transfer to another device`
  String get exportDataDescription {
    return Intl.message(
      'Export data to transfer to another device',
      name: 'exportDataDescription',
      desc: '',
      args: [],
    );
  }

  /// `Payment methods`
  String get paymentMethods {
    return Intl.message(
      'Payment methods',
      name: 'paymentMethods',
      desc: '',
      args: [],
    );
  }

  /// `Set up payment methods for your customers`
  String get paymentMethodsDescription {
    return Intl.message(
      'Set up payment methods for your customers',
      name: 'paymentMethodsDescription',
      desc: '',
      args: [],
    );
  }

  /// `About`
  String get about {
    return Intl.message('About', name: 'about', desc: '', args: []);
  }

  /// `App information`
  String get aboutDescription {
    return Intl.message(
      'App information',
      name: 'aboutDescription',
      desc: '',
      args: [],
    );
  }

  /// `Enter name`
  String get enterName {
    return Intl.message('Enter name', name: 'enterName', desc: '', args: []);
  }

  /// `Cash`
  String get cash {
    return Intl.message('Cash', name: 'cash', desc: '', args: []);
  }

  /// `Transfer`
  String get transfer {
    return Intl.message('Transfer', name: 'transfer', desc: '', args: []);
  }

  /// `Light`
  String get light {
    return Intl.message('Light', name: 'light', desc: '', args: []);
  }

  /// `Dark`
  String get dark {
    return Intl.message('Dark', name: 'dark', desc: '', args: []);
  }

  /// `What to export?`
  String get whatToExport {
    return Intl.message(
      'What to export?',
      name: 'whatToExport',
      desc: '',
      args: [],
    );
  }

  /// `All at once`
  String get allAtOnce {
    return Intl.message('All at once', name: 'allAtOnce', desc: '', args: []);
  }

  /// `Merch`
  String get merch {
    return Intl.message('Merch', name: 'merch', desc: '', args: []);
  }

  /// `Order history`
  String get orderHistory {
    return Intl.message(
      'Order history',
      name: 'orderHistory',
      desc: '',
      args: [],
    );
  }

  /// `Payment method`
  String get paymentMethod {
    return Intl.message(
      'Payment method',
      name: 'paymentMethod',
      desc: '',
      args: [],
    );
  }

  /// `Order successfully created!`
  String get orderSuccessfullyCreated {
    return Intl.message(
      'Order successfully created!',
      name: 'orderSuccessfullyCreated',
      desc: '',
      args: [],
    );
  }

  /// `Go to Orders`
  String get goToOrders {
    return Intl.message('Go to Orders', name: 'goToOrders', desc: '', args: []);
  }

  /// `Back`
  String get back {
    return Intl.message('Back', name: 'back', desc: '', args: []);
  }

  /// `Title`
  String get title {
    return Intl.message('Title', name: 'title', desc: '', args: []);
  }

  /// `Information`
  String get information {
    return Intl.message('Information', name: 'information', desc: '', args: []);
  }

  /// `Additional information`
  String get additionalInformation {
    return Intl.message(
      'Additional information',
      name: 'additionalInformation',
      desc: '',
      args: [],
    );
  }

  /// `Enter the title`
  String get enterTitle {
    return Intl.message(
      'Enter the title',
      name: 'enterTitle',
      desc: '',
      args: [],
    );
  }

  /// `Enter the information`
  String get enterInformation {
    return Intl.message(
      'Enter the information',
      name: 'enterInformation',
      desc: '',
      args: [],
    );
  }

  /// `Filter`
  String get filter {
    return Intl.message('Filter', name: 'filter', desc: '', args: []);
  }

  /// `Order amount`
  String get orderAmount {
    return Intl.message(
      'Order amount',
      name: 'orderAmount',
      desc: '',
      args: [],
    );
  }

  /// `Order creation period`
  String get orderCreationPeriod {
    return Intl.message(
      'Order creation period',
      name: 'orderCreationPeriod',
      desc: '',
      args: [],
    );
  }

  /// `Select a period`
  String get selectPeriod {
    return Intl.message(
      'Select a period',
      name: 'selectPeriod',
      desc: '',
      args: [],
    );
  }

  /// `Apply`
  String get apply {
    return Intl.message('Apply', name: 'apply', desc: '', args: []);
  }

  /// `Icon`
  String get icon {
    return Intl.message('Icon', name: 'icon', desc: '', args: []);
  }

  /// `Yes`
  String get yes {
    return Intl.message('Yes', name: 'yes', desc: '', args: []);
  }

  /// `No`
  String get no {
    return Intl.message('No', name: 'no', desc: '', args: []);
  }

  /// `You don't have any merch yet`
  String get noMerch {
    return Intl.message(
      'You don\'t have any merch yet',
      name: 'noMerch',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong`
  String get somethingWentWrong {
    return Intl.message(
      'Something went wrong',
      name: 'somethingWentWrong',
      desc: '',
      args: [],
    );
  }

  /// `Unexpected state`
  String get unexpectedState {
    return Intl.message(
      'Unexpected state',
      name: 'unexpectedState',
      desc: '',
      args: [],
    );
  }

  /// `Merch list not loaded`
  String get merchListNotLoaded {
    return Intl.message(
      'Merch list not loaded',
      name: 'merchListNotLoaded',
      desc: '',
      args: [],
    );
  }

  /// `Delete this merch?`
  String get deleteThisMerch {
    return Intl.message(
      'Delete this merch?',
      name: 'deleteThisMerch',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ru'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
