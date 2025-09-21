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

  /// `You don't have any festivals yet`
  String get noFestivals {
    return Intl.message(
      'You don\'t have any festivals yet',
      name: 'noFestivals',
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

  /// `Enter a correct number`
  String get enterCorrectNumber {
    return Intl.message(
      'Enter a correct number',
      name: 'enterCorrectNumber',
      desc: '',
      args: [],
    );
  }

  /// `Untitled`
  String get untitled {
    return Intl.message('Untitled', name: 'untitled', desc: '', args: []);
  }

  /// `Loading the cart`
  String get cartLoading {
    return Intl.message(
      'Loading the cart',
      name: 'cartLoading',
      desc: '',
      args: [],
    );
  }

  /// `Adding to cart`
  String get addingToCart {
    return Intl.message(
      'Adding to cart',
      name: 'addingToCart',
      desc: '',
      args: [],
    );
  }

  /// `Loading the festival list`
  String get festivalLoading {
    return Intl.message(
      'Loading the festival list',
      name: 'festivalLoading',
      desc: '',
      args: [],
    );
  }

  /// `Creating a festival`
  String get festivalCreating {
    return Intl.message(
      'Creating a festival',
      name: 'festivalCreating',
      desc: '',
      args: [],
    );
  }

  /// `Changing festival information`
  String get festivalChangeInfo {
    return Intl.message(
      'Changing festival information',
      name: 'festivalChangeInfo',
      desc: '',
      args: [],
    );
  }

  /// `Deleting a festival`
  String get festivalDeleting {
    return Intl.message(
      'Deleting a festival',
      name: 'festivalDeleting',
      desc: '',
      args: [],
    );
  }

  /// `Loading the merch list`
  String get merchLoading {
    return Intl.message(
      'Loading the merch list',
      name: 'merchLoading',
      desc: '',
      args: [],
    );
  }

  /// `Creating a new merch`
  String get merchCreating {
    return Intl.message(
      'Creating a new merch',
      name: 'merchCreating',
      desc: '',
      args: [],
    );
  }

  /// `Changing merch information`
  String get merchChangeInfo {
    return Intl.message(
      'Changing merch information',
      name: 'merchChangeInfo',
      desc: '',
      args: [],
    );
  }

  /// `Deleting a merch`
  String get merchDeleting {
    return Intl.message(
      'Deleting a merch',
      name: 'merchDeleting',
      desc: '',
      args: [],
    );
  }

  /// `-100`
  String get minus100 {
    return Intl.message('-100', name: 'minus100', desc: '', args: []);
  }

  /// `-50`
  String get minus50 {
    return Intl.message('-50', name: 'minus50', desc: '', args: []);
  }

  /// `-10`
  String get minus10 {
    return Intl.message('-10', name: 'minus10', desc: '', args: []);
  }

  /// `+10`
  String get plus10 {
    return Intl.message('+10', name: 'plus10', desc: '', args: []);
  }

  /// `+50`
  String get plus50 {
    return Intl.message('+50', name: 'plus50', desc: '', args: []);
  }

  /// `+100`
  String get plus100 {
    return Intl.message('+100', name: 'plus100', desc: '', args: []);
  }

  /// `The festival is not selected`
  String get festivalNotSelected {
    return Intl.message(
      'The festival is not selected',
      name: 'festivalNotSelected',
      desc: '',
      args: [],
    );
  }

  /// `Loading`
  String get loading {
    return Intl.message('Loading', name: 'loading', desc: '', args: []);
  }

  /// `Selecting a festival`
  String get festivalSelecting {
    return Intl.message(
      'Selecting a festival',
      name: 'festivalSelecting',
      desc: '',
      args: [],
    );
  }

  /// `Add your first payment method`
  String get addYourFirstPaymentMethod {
    return Intl.message(
      'Add your first payment method',
      name: 'addYourFirstPaymentMethod',
      desc: '',
      args: [],
    );
  }

  /// `Delete this payment method?`
  String get deleteThisPaymentMethod {
    return Intl.message(
      'Delete this payment method?',
      name: 'deleteThisPaymentMethod',
      desc: '',
      args: [],
    );
  }

  /// `Loading the payment method list`
  String get paymentMethodLoading {
    return Intl.message(
      'Loading the payment method list',
      name: 'paymentMethodLoading',
      desc: '',
      args: [],
    );
  }

  /// `Creating a payment method`
  String get paymentMethodCreating {
    return Intl.message(
      'Creating a payment method',
      name: 'paymentMethodCreating',
      desc: '',
      args: [],
    );
  }

  /// `Changing payment method information`
  String get paymentMethodChanging {
    return Intl.message(
      'Changing payment method information',
      name: 'paymentMethodChanging',
      desc: '',
      args: [],
    );
  }

  /// `Deleting a payment method`
  String get paymentMethodDeleting {
    return Intl.message(
      'Deleting a payment method',
      name: 'paymentMethodDeleting',
      desc: '',
      args: [],
    );
  }

  /// `Delete this festival?`
  String get deleteThisFestival {
    return Intl.message(
      'Delete this festival?',
      name: 'deleteThisFestival',
      desc: '',
      args: [],
    );
  }

  /// `The merch list is not loaded`
  String get merchIsNotLoaded {
    return Intl.message(
      'The merch list is not loaded',
      name: 'merchIsNotLoaded',
      desc: '',
      args: [],
    );
  }

  /// `Select a payment method`
  String get selectPaymentMethod {
    return Intl.message(
      'Select a payment method',
      name: 'selectPaymentMethod',
      desc: '',
      args: [],
    );
  }

  /// `You don't have any payment methods yet`
  String get noPaymentMethods {
    return Intl.message(
      'You don\'t have any payment methods yet',
      name: 'noPaymentMethods',
      desc: '',
      args: [],
    );
  }

  /// `Error loading payment methods`
  String get errorLoadingPaymentMethods {
    return Intl.message(
      'Error loading payment methods',
      name: 'errorLoadingPaymentMethods',
      desc: '',
      args: [],
    );
  }

  /// `Payment methods are not loaded`
  String get paymentMethodsNotLoaded {
    return Intl.message(
      'Payment methods are not loaded',
      name: 'paymentMethodsNotLoaded',
      desc: '',
      args: [],
    );
  }

  /// `No matching merches was found`
  String get noMatchingMerch {
    return Intl.message(
      'No matching merches was found',
      name: 'noMatchingMerch',
      desc: '',
      args: [],
    );
  }

  /// `Temporary unavailable`
  String get temporaryUnavailable {
    return Intl.message(
      'Temporary unavailable',
      name: 'temporaryUnavailable',
      desc: '',
      args: [],
    );
  }

  /// `You don't have any saved receipts`
  String get noReceipts {
    return Intl.message(
      'You don\'t have any saved receipts',
      name: 'noReceipts',
      desc: '',
      args: [],
    );
  }

  /// `Loading receipts`
  String get receiptsLoading {
    return Intl.message(
      'Loading receipts',
      name: 'receiptsLoading',
      desc: '',
      args: [],
    );
  }

  /// `Saving the receipt`
  String get receiptSaving {
    return Intl.message(
      'Saving the receipt',
      name: 'receiptSaving',
      desc: '',
      args: [],
    );
  }

  /// `Deleting the receipt`
  String get receiptDeleting {
    return Intl.message(
      'Deleting the receipt',
      name: 'receiptDeleting',
      desc: '',
      args: [],
    );
  }

  /// `Unable to delete a merch, because it's in the cart`
  String get unableToDeleteMerch {
    return Intl.message(
      'Unable to delete a merch, because it\'s in the cart',
      name: 'unableToDeleteMerch',
      desc: '',
      args: [],
    );
  }

  /// `No matching orders was found`
  String get noMatchingOrders {
    return Intl.message(
      'No matching orders was found',
      name: 'noMatchingOrders',
      desc: '',
      args: [],
    );
  }

  /// `Sorting`
  String get sorting {
    return Intl.message('Sorting', name: 'sorting', desc: '', args: []);
  }

  /// `Clear filter`
  String get clearFilter {
    return Intl.message(
      'Clear filter',
      name: 'clearFilter',
      desc: '',
      args: [],
    );
  }

  /// `The order list is not loaded`
  String get ordersIsNotLoaded {
    return Intl.message(
      'The order list is not loaded',
      name: 'ordersIsNotLoaded',
      desc: '',
      args: [],
    );
  }

  /// `Donate`
  String get donate {
    return Intl.message('Donate', name: 'donate', desc: '', args: []);
  }

  /// `Send tips for project growth`
  String get donateDescription {
    return Intl.message(
      'Send tips for project growth',
      name: 'donateDescription',
      desc: '',
      args: [],
    );
  }

  /// `Couldn't open the page`
  String get couldntOpenPage {
    return Intl.message(
      'Couldn\'t open the page',
      name: 'couldntOpenPage',
      desc: '',
      args: [],
    );
  }

  /// `Opening a page`
  String get openingPage {
    return Intl.message(
      'Opening a page',
      name: 'openingPage',
      desc: '',
      args: [],
    );
  }

  /// `Go to the tip payment page?`
  String get goToTheDonatePage {
    return Intl.message(
      'Go to the tip payment page?',
      name: 'goToTheDonatePage',
      desc: '',
      args: [],
    );
  }

  /// `Loading the category list`
  String get categoryLoading {
    return Intl.message(
      'Loading the category list',
      name: 'categoryLoading',
      desc: '',
      args: [],
    );
  }

  /// `Creating a category`
  String get categoryCreating {
    return Intl.message(
      'Creating a category',
      name: 'categoryCreating',
      desc: '',
      args: [],
    );
  }

  /// `Deleting a category`
  String get categoryDeleting {
    return Intl.message(
      'Deleting a category',
      name: 'categoryDeleting',
      desc: '',
      args: [],
    );
  }

  /// `You don't have any categories yet`
  String get noCategories {
    return Intl.message(
      'You don\'t have any categories yet',
      name: 'noCategories',
      desc: '',
      args: [],
    );
  }

  /// `Loading error`
  String get loadingError {
    return Intl.message(
      'Loading error',
      name: 'loadingError',
      desc: '',
      args: [],
    );
  }

  /// `Delete this category?`
  String get deleteThisCategory {
    return Intl.message(
      'Delete this category?',
      name: 'deleteThisCategory',
      desc: '',
      args: [],
    );
  }

  /// `Unable to delete a category that is being used`
  String get unableToDeleteCategory {
    return Intl.message(
      'Unable to delete a category that is being used',
      name: 'unableToDeleteCategory',
      desc: '',
      args: [],
    );
  }

  /// `0 ₽`
  String get zeroRubles {
    return Intl.message('0 ₽', name: 'zeroRubles', desc: '', args: []);
  }

  /// `₽`
  String get ruble {
    return Intl.message('₽', name: 'ruble', desc: '', args: []);
  }

  /// `The file was saved successfully`
  String get fileSuccessfullySaved {
    return Intl.message(
      'The file was saved successfully',
      name: 'fileSuccessfullySaved',
      desc: '',
      args: [],
    );
  }

  /// `File path:`
  String get filePath {
    return Intl.message('File path:', name: 'filePath', desc: '', args: []);
  }

  /// `OK`
  String get ok {
    return Intl.message('OK', name: 'ok', desc: '', args: []);
  }

  /// `Importing the merch list`
  String get merchImporting {
    return Intl.message(
      'Importing the merch list',
      name: 'merchImporting',
      desc: '',
      args: [],
    );
  }

  /// `Importing the receipt list`
  String get receiptImporting {
    return Intl.message(
      'Importing the receipt list',
      name: 'receiptImporting',
      desc: '',
      args: [],
    );
  }

  /// `Importing the payment method list`
  String get paymentMethodImporting {
    return Intl.message(
      'Importing the payment method list',
      name: 'paymentMethodImporting',
      desc: '',
      args: [],
    );
  }

  /// `Importing the festival list`
  String get festivalImporting {
    return Intl.message(
      'Importing the festival list',
      name: 'festivalImporting',
      desc: '',
      args: [],
    );
  }

  /// `Exit the app?`
  String get exitTheApp {
    return Intl.message(
      'Exit the app?',
      name: 'exitTheApp',
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
