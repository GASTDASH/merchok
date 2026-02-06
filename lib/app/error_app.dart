import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:merchok/core/core.dart';
import 'package:merchok/generated/l10n.dart';

class ErrorApp extends StatelessWidget {
  const ErrorApp({super.key, required this.exception, this.stack});

  final Object exception;
  final StackTrace? stack;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MerchOK',
      home: CustomErrorWidget(
        FlutterErrorDetails(exception: exception, stack: stack),
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
