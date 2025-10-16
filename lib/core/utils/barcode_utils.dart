import 'dart:convert';
import 'dart:typed_data';

import 'package:merchok/core/core.dart';
import 'package:merchok/features/merch/merch.dart';

abstract class BarcodeUtils {
  static String addMerchInfo({required String svg, required Merch merch}) => svg
      .replaceFirst(
        '<svg viewBox="0.00000 0.00000 200.00000 80.00000" xmlns="http://www.w3.org/2000/svg">',
        '<svg viewBox="0.00000 0.00000 200.00000 110.00000" xmlns="http://www.w3.org/2000/svg">',
      )
      .replaceFirst(
        '<text style="fill: #000000; font-family: &quot;monospace&quot;; font-size: 16.00000px" x="0.00000" y="0.00000"></text>',
        '<text style="fill: #000000; font-family: sans-serif; font-size: 15px" y="82%" dominant-baseline="middle">${merch.name}</text><text style="fill: #000000; font-family: sans-serif; font-size: 12px" y="95%" dominant-baseline="middle">${merch.price.truncateIfInt()}</text>',
      );

  static Uint8List merge(
    List<Uint8List> svgFiles, {
    int columns = 7, // 7 колонок и 9 строк = A4
    double spacing = 20,
  }) {
    if (svgFiles.isEmpty) {
      throw ArgumentError('Список svgFiles не может быть пустым');
    }

    final svgStrings = svgFiles.map((e) => utf8.decode(e)).toList();

    // Извлекаем viewBox или размеры каждого SVG (по возможности)
    final RegExp viewBoxRegex = RegExp(r'viewBox="([\d.\s-]+)"');
    final RegExp widthRegex = RegExp(r'width="([\d.]+)"');
    final RegExp heightRegex = RegExp(r'height="([\d.]+)"');

    final List<Map<String, double>> sizes = [];

    for (final svg in svgStrings) {
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
        if (wMatch != null)
          width = double.tryParse(wMatch.group(1) ?? '') ?? 100;
        if (hMatch != null)
          height = double.tryParse(hMatch.group(1) ?? '') ?? 100;
      }
      sizes.add({'width': width, 'height': height});
    }

    final double itemWidth = sizes.first['width']!;
    final double itemHeight = sizes.first['height']!;
    final int rows = (svgFiles.length / columns).ceil();

    final double totalWidth = columns * itemWidth + (columns - 1) * spacing;
    final double totalHeight = rows * itemHeight + (rows - 1) * spacing;

    final StringBuffer buffer = StringBuffer();
    buffer.writeln(
      '<svg xmlns="http://www.w3.org/2000/svg" width="$totalWidth" height="$totalHeight" viewBox="0 0 $totalWidth $totalHeight">',
    );

    for (int i = 0; i < svgStrings.length; i++) {
      final col = i % columns;
      final row = i ~/ columns;
      final dx = col * (itemWidth + spacing);
      final dy = row * (itemHeight + spacing);

      final inner = svgStrings[i]
          .replaceAll(RegExp(r'<\?xml.*?\?>'), '')
          .replaceAll(RegExp(r'<svg[^>]*>'), '')
          .replaceAll('</svg>', '');

      buffer.writeln('<g transform="translate($dx,$dy)">$inner</g>');
    }

    buffer.writeln('</svg>');

    return Uint8List.fromList(utf8.encode(buffer.toString()));
  }
}
