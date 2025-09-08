import 'package:flutter/material.dart';

class SettingsRadioOption<T> extends StatelessWidget {
  const SettingsRadioOption({
    super.key,
    required this.text,
    required this.value,
  });

  final String text;
  final T value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      title: Text(text, style: theme.textTheme.titleLarge),
      trailing: Radio.adaptive(value: value),
    );
  }
}
