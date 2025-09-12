import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:merchok/core/core.dart';
import 'package:merchok/generated/l10n.dart';

class _BaseBanner extends StatelessWidget {
  const _BaseBanner(this.children);

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            spacing: 32,
            mainAxisSize: MainAxisSize.min,
            children: children,
          ),
        ),
      ),
    );
  }
}

class InfoBanner extends StatelessWidget {
  const InfoBanner({super.key, required this.text}) : icon = null;

  const InfoBanner.icon({super.key, required this.text, required this.icon});

  const InfoBanner.error({super.key, required String message})
    : icon = null,
      text = message;

  final String text;
  final String? icon;

  @override
  Widget build(BuildContext context) {
    return _BaseBanner([
      Text(
        text,
        style: Theme.of(context).textTheme.headlineLarge,
        textAlign: TextAlign.center,
      ),
      if (icon != null) SvgPicture.asset(icon!, height: 64),
    ]);
  }
}

class ErrorBanner extends StatelessWidget {
  const ErrorBanner({super.key, this.message});

  final String? message;

  @override
  Widget build(BuildContext context) {
    return _BaseBanner([
      Icon(Icons.warning_amber, size: 64),
      Text(
        S.of(context).somethingWentWrong,
        style: Theme.of(context).textTheme.headlineMedium,
      ),
      if (message != null) Text(message!),
    ]);
  }
}

class UnexpectedStateBanner extends StatelessWidget {
  const UnexpectedStateBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return _BaseBanner([
      Text(
        S.of(context).unexpectedState,
        style: Theme.of(context).textTheme.headlineLarge,
        textAlign: TextAlign.center,
      ),
    ]);
  }
}

class LoadingBanner extends StatelessWidget {
  const LoadingBanner({super.key, this.message});

  final String? message;

  @override
  Widget build(BuildContext context) {
    return _BaseBanner([
      LoadingIndicator(),
      if (message != null)
        Text(
          message!,
          style: Theme.of(context).textTheme.headlineLarge,
          textAlign: TextAlign.center,
        ),
    ]);
  }
}
