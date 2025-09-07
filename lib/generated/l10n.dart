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

  /// `Creation Date: dd.mm.yyyy`
  String get creationDate {
    return Intl.message(
      'Creation Date: dd.mm.yyyy',
      name: 'creationDate',
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
