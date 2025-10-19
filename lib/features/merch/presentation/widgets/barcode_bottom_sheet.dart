import 'package:barcode_widget/barcode_widget.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:merchok/core/core.dart';
import 'package:merchok/features/merch/merch.dart';
import 'package:merchok/generated/l10n.dart';

class BarcodeBottomSheet extends StatelessWidget {
  const BarcodeBottomSheet({super.key, required this.merch});

  final Merch merch;

  Future<String?> _save(BuildContext context) async {
    final svg = BarcodeUtils.addMerchInfo(
      svg: Barcode.dataMatrix().toSvg(merch.id),
      merch: merch,
    );

    final bytes = await SvgUtils.svgToPng(
      SvgStringLoader(SvgUtils.addBackground(svg)),
      context,
      width: 200,
      height: 110,
    );

    return await FileSaver.instance.saveAs(
      name: 'code-${merch.id}',
      bytes: bytes,
      fileExtension: 'png',
      mimeType: MimeType.png,
    );
  }

  Future<void> _showSuccessfullySavedDialog(
    BuildContext context,
    String path,
  ) async => await showDialog(
    context: context,
    builder: (context) => SuccessfullySavedDialog(path: path),
  );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
      ),
      height: 400,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BarcodeWidget(data: merch.id, barcode: Barcode.dataMatrix()),
          const SizedBox(height: 8),
          Text(
            merch.name,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(merch.price.truncateIfInt(), style: theme.textTheme.titleMedium),
          const SizedBox(height: 16),
          FittedBox(
            child: BaseButton(
              onTap: () async {
                final path = await _save(context);
                if (path == null || !context.mounted) return;
                _showSuccessfullySavedDialog(context, path);
              },
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Text(S.of(context).save),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
