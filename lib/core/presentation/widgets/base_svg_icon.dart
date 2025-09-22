import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BaseSvgIcon extends SvgPicture {
  BaseSvgIcon(
    BuildContext context,
    String assetName, {
    super.key,
    super.width,
    super.height,
    ColorFilter? colorFilter,
  }) : super(
         SvgAssetLoader(assetName),
         colorFilter:
             colorFilter ??
             ColorFilter.mode(
               Theme.of(context).colorScheme.onSurface,
               BlendMode.srcIn,
             ),
       );
}
