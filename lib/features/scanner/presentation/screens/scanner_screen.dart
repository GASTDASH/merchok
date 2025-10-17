import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:talker_flutter/talker_flutter.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  final controller = MobileScannerController(detectionTimeoutMs: 500);

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  void _onDetect(BuildContext context, BarcodeCapture barcodes) {
    GetIt.I<Talker>().debug('Detected!');
    final value = barcodes.barcodes.first.rawValue;
    if (context.canPop()) context.pop(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: MobileScanner(
          controller: controller,
          tapToFocus: true,
          overlayBuilder: (context, constraints) => Center(
            child: Container(
              decoration: ShapeDecoration(
                shape: _QrScannerOverlayShape(
                  borderColor: Colors.white,
                  borderRadius: 10,
                  borderLength: 20,
                  borderWidth: 5,
                  cutOutSize: constraints.maxWidth / 1.5,
                ),
              ),
            ),
          ),
          onDetect: (barcodes) => _onDetect(context, barcodes),
        ),
      ),
    );
  }
}

class _QrScannerOverlayShape extends ShapeBorder {
  _QrScannerOverlayShape({
    this.borderColor = Colors.red,
    this.borderWidth = 3.0,
    this.overlayColor = const Color.fromRGBO(0, 0, 0, 0.7),
    this.borderRadius = 0,
    this.borderLength = 40,
    double? cutOutSize,
  }) : cutOutWidth = cutOutSize ?? 250,
       cutOutHeight = cutOutSize ?? 250 {
    assert(
      borderLength <= min(cutOutWidth, cutOutHeight) / 2 + borderWidth * 2,
      "Border can't be larger than ${min(cutOutWidth, cutOutHeight) / 2 + borderWidth * 2}",
    );
  }

  final Color borderColor;
  final double borderWidth;
  final Color overlayColor;
  final double borderRadius;
  final double borderLength;
  final double cutOutWidth;
  final double cutOutHeight;

  @override
  EdgeInsetsGeometry get dimensions => const EdgeInsets.all(10);

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return Path()
      ..fillType = PathFillType.evenOdd
      ..addPath(getOuterPath(rect), Offset.zero);
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    Path getLeftTopPath(Rect rect) {
      return Path()
        ..moveTo(rect.left, rect.bottom)
        ..lineTo(rect.left, rect.top)
        ..lineTo(rect.right, rect.top);
    }

    return getLeftTopPath(rect)
      ..lineTo(rect.right, rect.bottom)
      ..lineTo(rect.left, rect.bottom)
      ..lineTo(rect.left, rect.top);
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    final width = rect.width;
    final borderWidthSize = width / 2;
    final height = rect.height;
    final borderOffset = borderWidth / 2;
    final mBorderLength =
        borderLength > min(cutOutHeight, cutOutHeight) / 2 + borderWidth * 2
        ? borderWidthSize / 2
        : borderLength;
    final mCutOutWidth = cutOutWidth < width
        ? cutOutWidth
        : width - borderOffset;
    final mCutOutHeight = cutOutHeight < height
        ? cutOutHeight
        : height - borderOffset;

    final backgroundPaint = Paint()
      ..color = overlayColor
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;

    final boxPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.fill
      ..blendMode = BlendMode.dstOut;

    final cutOutRect = Rect.fromLTWH(
      rect.left + width / 2 - mCutOutWidth / 2 + borderOffset,
      rect.top + height / 2 - mCutOutHeight / 2 + borderOffset,
      mCutOutWidth - borderOffset * 2,
      mCutOutHeight - borderOffset * 2,
    );

    canvas
      ..saveLayer(rect, backgroundPaint)
      ..drawRect(rect, backgroundPaint)
      // Draw top right corner
      ..drawRRect(
        RRect.fromLTRBAndCorners(
          cutOutRect.right - mBorderLength,
          cutOutRect.top,
          cutOutRect.right,
          cutOutRect.top + mBorderLength,
          topRight: Radius.circular(borderRadius),
        ),
        borderPaint,
      )
      // Draw top left corner
      ..drawRRect(
        RRect.fromLTRBAndCorners(
          cutOutRect.left,
          cutOutRect.top,
          cutOutRect.left + mBorderLength,
          cutOutRect.top + mBorderLength,
          topLeft: Radius.circular(borderRadius),
        ),
        borderPaint,
      )
      // Draw bottom right corner
      ..drawRRect(
        RRect.fromLTRBAndCorners(
          cutOutRect.right - mBorderLength,
          cutOutRect.bottom - mBorderLength,
          cutOutRect.right,
          cutOutRect.bottom,
          bottomRight: Radius.circular(borderRadius),
        ),
        borderPaint,
      )
      // Draw bottom left corner
      ..drawRRect(
        RRect.fromLTRBAndCorners(
          cutOutRect.left,
          cutOutRect.bottom - mBorderLength,
          cutOutRect.left + mBorderLength,
          cutOutRect.bottom,
          bottomLeft: Radius.circular(borderRadius),
        ),
        borderPaint,
      )
      ..drawRRect(
        RRect.fromRectAndRadius(cutOutRect, Radius.circular(borderRadius)),
        boxPaint,
      )
      ..restore();
  }

  @override
  ShapeBorder scale(double t) {
    return _QrScannerOverlayShape(
      borderColor: borderColor,
      borderWidth: borderWidth,
      overlayColor: overlayColor,
    );
  }
}
