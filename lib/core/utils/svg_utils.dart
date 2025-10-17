import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

abstract class SvgUtils {
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
}
