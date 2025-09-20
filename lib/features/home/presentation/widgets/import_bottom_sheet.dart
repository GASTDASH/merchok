import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:merchok/core/core.dart';
import 'package:merchok/features/merch/merch.dart';
import 'package:merchok/generated/l10n.dart';
import 'package:talker_flutter/talker_flutter.dart';

class ImportBottomSheet extends StatelessWidget {
  const ImportBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(32),
      ),
      height: 300,
      padding: EdgeInsets.all(16),
      child: Column(
        spacing: 12,
        children: [
          Text(
            S.of(context).whereToImportFrom,
            style: theme.textTheme.titleLarge?.copyWith(fontSize: 20),
          ),
          Expanded(
            child: Row(
              spacing: 12,
              children: [
                Expanded(
                  child: BaseContainer(
                    onTap: () {},
                    height: 150,
                    elevation: 8,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          S.of(context).fromExcel,
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(S.of(context).notAvailableYet),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: BaseContainer(
                    onTap: () async {
                      final bloc = context.read<MerchBloc>();

                      final result = await FilePicker.platform.pickFiles();
                      if (result == null) return;
                      if (result.files.first.path == null) return;

                      final file = File(result.files.first.path!);

                      final table = CsvToListConverter().convert(
                        await file.readAsString(),
                      );

                      if (table.first[0] != 'id' ||
                          table.first[1] != 'name' ||
                          table.first[2] != 'description' ||
                          table.first[3] != 'price' ||
                          table.first[4] != 'purchasePrice' ||
                          table.first[5] != 'image' ||
                          table.first[6] != 'categoryId') {
                        return;
                      }

                      final List<Merch> merchList = [
                        ...table.skip(1).map((row) {
                          final List? image = jsonDecode(row[5].toString());

                          return Merch(
                            id: row[0],
                            name: row[1],
                            description: row[2] != '' ? row[2] : null,
                            price: row[3],
                            purchasePrice: double.tryParse(row[4]),
                            image: image != null
                                ? Uint8List.fromList(image.cast<int>())
                                : null,
                            categoryId: row[6] != '' ? row[6] : null,
                          );
                        }),
                      ];

                      for (var merch in merchList) {
                        GetIt.I<Talker>().debug(merch);
                      }

                      bloc.add(MerchImport(merchList: merchList));

                      if (context.mounted) context.pop();
                    },
                    height: 150,
                    elevation: 8,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          S.of(context).fromCSV,
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(S.of(context).recommended),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
