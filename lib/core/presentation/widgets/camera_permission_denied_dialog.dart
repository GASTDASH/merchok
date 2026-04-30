import 'package:flutter/material.dart';
import 'package:merchok/generated/l10n.dart';

class CameraPermissionDeniedDialog extends StatelessWidget {
  const CameraPermissionDeniedDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Text(
          S.of(context).cameraPermissionDenied,
          style: Theme.of(context).textTheme.titleLarge,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

Future<void> showCameraPermissionDeniedDialog(BuildContext context) async =>
    await showDialog(
      context: context,
      builder: (context) => const CameraPermissionDeniedDialog(),
    );
