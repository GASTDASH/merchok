import 'package:flutter/material.dart';
import 'package:merchok/features/about/about.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key, required this.languageCode});

  final String languageCode;

  @override
  Widget build(BuildContext context) =>
      MarkdownScreen(assetName: 'assets/docs/privacy_policy/$languageCode.md');
}
