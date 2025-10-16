import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:talker_flutter/talker_flutter.dart';

class ScannerScreen extends StatelessWidget {
  const ScannerScreen({super.key});

  void _onDetect(BuildContext context, BarcodeCapture barcodes) {
    GetIt.I<Talker>().debug('Detected!');
    final value = barcodes.barcodes.first.rawValue;
    context.pop(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: MobileScanner(
          controller: MobileScannerController(detectionTimeoutMs: 500),
          tapToFocus: true,
          onDetect: (barcodes) => _onDetect(context, barcodes),
        ),
      ),
    );
  }
}
