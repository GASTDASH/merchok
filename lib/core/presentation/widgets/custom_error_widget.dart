import 'package:flutter/material.dart';
import 'package:merchok/generated/l10n.dart';

class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget(this.details, {super.key});

  final FlutterErrorDetails details;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.warning_amber, size: 64, color: Colors.red),
              Text(
                S.of(context).unexpectedFlutterError,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  height: 1.2,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              Text(details.exceptionAsString(), style: TextStyle(fontSize: 18)),
              SizedBox(height: 32),
              Text(details.toDiagnosticsNode().toStringDeep()),
            ],
          ),
        ),
      ),
    );
  }
}
