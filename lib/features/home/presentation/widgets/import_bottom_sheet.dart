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
import 'package:merchok/features/festival/festival.dart';
import 'package:merchok/features/merch/merch.dart';
import 'package:merchok/features/orders/orders.dart';
import 'package:merchok/features/payment_method/payment_method.dart';
import 'package:merchok/generated/l10n.dart';
import 'package:talker_flutter/talker_flutter.dart';

class ImportBottomSheet extends StatelessWidget {
  const ImportBottomSheet({super.key});

  Future<void> _import(BuildContext context) async {
    final merchBloc = context.read<MerchBloc>();
    final orderBloc = context.read<OrderBloc>();
    final paymentMethodBloc = context.read<PaymentMethodBloc>();
    final festivalBloc = context.read<FestivalBloc>();

    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;
    if (result.files.first.path == null) return;

    final file = File(result.files.first.path!);
    final fileName = file.path.split('/').last.split('-').first;

    final table = const CsvToListConverter().convert(await file.readAsString());

    switch (fileName) {
      case 'merch':
        final List<Merch> merchList = [
          ...table.skip(1).map((row) {
            final List? thumbnail = jsonDecode(row[5].toString());

            return Merch(
              id: row[0],
              name: row[1].toString(),
              description: row[2] != '' ? row[2] : null,
              price: double.parse(row[3].toString()),
              purchasePrice: double.tryParse(row[4].toString()),
              thumbnail: thumbnail != null
                  ? Uint8List.fromList(thumbnail.cast<int>())
                  : null,
              categoryId: row[6] != '' ? row[6] : null,
            );
          }),
        ];

        GetIt.I<Talker>().debug(
          'Импортирование мерча: \n${merchList.join('\n')}', // translate-me-ignore
        );
        merchBloc.add(MerchImport(merchList: merchList));
        break;
      case 'orders':
        final List<Order> orderList = [
          ...table.skip(1).map((row) {
            return Order(
              id: row[0],
              orderItems: [
                for (var json in jsonDecode(row[1])) OrderItem.fromJson(json),
              ],
              createdAt: DateTime.fromMillisecondsSinceEpoch(row[2]),
              festival: Festival.fromJson(row[3]),
              paymentMethod: PaymentMethod.fromJson(row[4]),
            );
          }),
        ];

        GetIt.I<Talker>().debug(
          'Импортирование чеков: \n${orderList.join('\n')}', // translate-me-ignore
        );
        orderBloc.add(OrderImport(orderList: orderList));
        break;
      case 'payment':
        final List<PaymentMethod> paymentMethodList = [
          ...table.skip(1).map((row) {
            return PaymentMethod(
              id: row[0],
              name: row[1].toString(),
              information: row[2].toString(),
              description: row[3] != '' ? row[3] : null,
              iconPath: row[4] != '' ? row[4] : null,
            );
          }),
        ];

        GetIt.I<Talker>().debug(
          'Импортирование способов оплаты: \n${paymentMethodList.join('\n')}', // translate-me-ignore
        );
        paymentMethodBloc.add(
          PaymentMethodImport(paymentMethodList: paymentMethodList),
        );
        break;
      case 'festivals':
        final List<Festival> festivalList = [
          ...table.skip(1).map((row) {
            return Festival(
              id: row[0],
              name: row[1].toString(),
              startDate: DateTime.fromMillisecondsSinceEpoch(row[2]),
              endDate: DateTime.fromMillisecondsSinceEpoch(row[3]),
            );
          }),
        ];

        GetIt.I<Talker>().debug(
          'Импортирование фестивалей: \n${festivalList.join('\n')}', // translate-me-ignore
        );
        festivalBloc.add(FestivalImport(festivalList: festivalList));
        break;
    }
  }

  Future<void> _showImportErrorDialog(BuildContext context) async =>
      await showDialog(
        context: context,
        builder: (context) => Dialog(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: 16,
              children: [
                Text(
                  'Произошла ошибка при импорте',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const Text('Убедитесь, что название файла не было изменено'),
              ],
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(32),
      ),
      height: 300,
      padding: const EdgeInsets.all(16),
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
                      try {
                        await _import(context);
                      } catch (e) {
                        if (!context.mounted) return;
                        _showImportErrorDialog(context);
                      }

                      if (context.mounted) context.pop();
                    },
                    height: 150,
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
