import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

abstract class SvgUtils {
  static Size getSize(String svg) {
    // Извлекаем viewBox или размеры каждого SVG (по возможности)
    final RegExp viewBoxRegex = RegExp(r'viewBox="([\d.\s-]+)"');
    final RegExp widthRegex = RegExp(r'width="([\d.]+)"');
    final RegExp heightRegex = RegExp(r'height="([\d.]+)"');

    double width = 200, height = 110;
    final vbMatch = viewBoxRegex.firstMatch(svg);
    if (vbMatch != null) {
      final parts = vbMatch
          .group(1)!
          .split(RegExp(r'\s+'))
          .map(double.parse)
          .toList();
      width = parts[2];
      height = parts[3];
    } else {
      final wMatch = widthRegex.firstMatch(svg);
      final hMatch = heightRegex.firstMatch(svg);
      if (wMatch != null) width = double.tryParse(wMatch.group(1) ?? '') ?? 100;
      if (hMatch != null)
        height = double.tryParse(hMatch.group(1) ?? '') ?? 100;
    }
    return Size(width, height);
  }

  static Future<Uint8List> svgToPng(
    BytesLoader loader,
    BuildContext context, {
    required int width,
    required int height,
  }) async {
    final pictureInfo = await vg.loadPicture(loader, context);

    final image = await pictureInfo.picture.toImage(width, height);
    final bytesData = await image.toByteData(format: ImageByteFormat.png);

    if (bytesData == null) throw Exception('Unable to convert SVG to PNG');

    return bytesData.buffer.asUint8List();
  }

  static String addBackground(String svg, {Color color = Colors.white}) {
    final size = getSize(svg);

    final svgTag = RegExp(r'<svg.*?>').firstMatch(svg)!.group(0)!;
    svg = svg.replaceFirst(
      svgTag,
      '<svg xmlns="http://www.w3.org/2000/svg" width="${size.width}" height="${size.height}" viewBox="0 0 ${size.width} ${size.height}"><rect width="${size.width}" height="${size.height}" fill="white"/>',
    );

    return svg;
  }
}
