import 'dart:convert';

import 'package:barcode_widget/barcode_widget.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:merchok/core/core.dart';
import 'package:merchok/features/merch/merch.dart';
import 'package:merchok/generated/l10n.dart';

class BarcodeBottomSheet extends StatelessWidget {
  const BarcodeBottomSheet({super.key, required this.merch});

  final Merch merch;

  Future<String?> _save() async {
    String svg = Barcode.dataMatrix().toSvg(merch.id);
    svg = svg.replaceFirst(
      '<svg viewBox="0.00000 0.00000 200.00000 80.00000" xmlns="http://www.w3.org/2000/svg">',
      '<svg viewBox="0.00000 0.00000 200.00000 110.00000" xmlns="http://www.w3.org/2000/svg">',
    );
    svg = svg.replaceFirst(
      '<text style="fill: #000000; font-family: &quot;monospace&quot;; font-size: 16.00000px" x="0.00000" y="0.00000"></text>',
      '<text style="fill: #000000; font-family: sans-serif; font-size: 15px" x="50%" y="82%" dominant-baseline="middle" text-anchor="middle">${merch.name}</text><text style="fill: #000000; font-family: sans-serif; font-size: 12px" x="50%" y="95%" dominant-baseline="middle" text-anchor="middle">${merch.price.truncateIfInt()}</text>',
    );
    final bytes = utf8.encode(svg);
    return await FileSaver.instance.saveAs(
      name: 'code-${merch.id}',
      bytes: bytes,
      fileExtension: 'svg',
      mimeType: MimeType.svg,
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
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(32),
      ),
      height: 400,
      child: Column(
        spacing: 32,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BarcodeWidget(data: merch.id, barcode: Barcode.dataMatrix()),
          FittedBox(
            child: BaseButton(
              onTap: () async {
                final path = await _save();
                if (path == null || !context.mounted) return;
                _showSuccessfullySavedDialog(context, path);
              },
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  S.of(context).save,
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
