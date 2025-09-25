import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

@Deprecated('Use AppIcons instead')
class BaseSvgIcon extends SvgPicture {
  BaseSvgIcon(
    BuildContext context,
    String assetName, {
    super.key,
    super.width,
    super.height,
    AssetBundle? bundle,
    String? package,
    SvgTheme? theme,
    ColorMapper? colorMapper,
    ColorFilter? colorFilter,
  }) : super(
         SvgAssetLoader(
           assetName,
           packageName: package,
           assetBundle: bundle,
           theme: theme,
           colorMapper: colorMapper,
         ),
         colorFilter:
             colorFilter ??
             ColorFilter.mode(
               Theme.of(context).colorScheme.onSurface,
               BlendMode.srcIn,
             ),
       );
}
