import 'package:flutter/material.dart';
import 'package:merchok/features/about/about.dart';

class TermsConditionsScreen extends StatelessWidget {
  const TermsConditionsScreen({super.key, required this.languageCode});

  final String languageCode;

  @override
  Widget build(BuildContext context) => MarkdownScreen(
    assetName: 'assets/docs/terms_conditions/$languageCode.md',
  );
}
