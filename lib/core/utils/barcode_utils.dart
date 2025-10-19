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

  static String merge(
    List<String> svgStrings, {
    int columns = 7, // 7 колонок и 9 строк = A4
    double spacing = 20,
  }) {
    assert(svgStrings.isNotEmpty, 'Список svgStrings не может быть пустым');

    final size = SvgUtils.getSize(svgStrings.first);

    final double itemWidth = size.width;
    final double itemHeight = size.height;
    final int rows = (svgStrings.length / columns).ceil();

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

    return buffer.toString();
  }
}
