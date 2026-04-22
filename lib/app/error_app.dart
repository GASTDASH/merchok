import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:merchok/core/core.dart';
import 'package:merchok/generated/l10n.dart';

class ErrorApp extends StatelessWidget {
  const ErrorApp(this.details, {super.key});

  final FlutterErrorDetails details;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MerchOK',
      home: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: CustomErrorWidget(details),
          ),
        ),
      ),
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
    );
  }
}
