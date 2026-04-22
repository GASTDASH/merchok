import 'package:flutter/material.dart';
import 'package:merchok/generated/l10n.dart';

class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget(this.details, {super.key});

  final FlutterErrorDetails details;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: .center,
      crossAxisAlignment: .start,
      children: [
        const Icon(Icons.warning_amber, size: 32, color: Colors.red),
        const SizedBox(height: 8),
        Text(
          S.of(context).unexpectedFlutterError,
          style: const TextStyle(fontSize: 18, fontWeight: .w500, height: 1.2),
        ),
        const SizedBox(height: 8),
        Text(details.exceptionAsString(), style: const TextStyle(fontSize: 16)),
        const SizedBox(height: 8),
        Text(
          details.toDiagnosticsNode().toStringDeep(),
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}
