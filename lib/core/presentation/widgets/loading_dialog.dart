import 'package:flutter/material.dart';
import 'package:merchok/core/core.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({super.key, this.message});

  final String? message;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Dialog(
        child: Padding(
          padding: EdgeInsetsGeometry.all(32),
          child: Column(
            spacing: 16,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (message != null)
                Text(
                  message!,
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
              LoadingIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> showLoadingDialog({
  required BuildContext context,
  String? message,
}) async => await showDialog(
  barrierDismissible: false,
  context: context,
  builder: (context) => LoadingDialog(message: message),
);
