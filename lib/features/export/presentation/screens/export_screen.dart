import 'dart:convert';

import 'package:csv/csv.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:merchok/core/core.dart';
import 'package:merchok/features/export/export.dart';
import 'package:merchok/features/festival/festival.dart';
import 'package:merchok/features/merch/merch.dart';
import 'package:merchok/features/orders/orders.dart';
import 'package:merchok/features/payment_method/payment_method.dart';
import 'package:merchok/generated/l10n.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:talker_flutter/talker_flutter.dart';

class ExportScreen extends StatefulWidget {
  const ExportScreen({super.key});

  @override
  State<ExportScreen> createState() => _ExportScreenState();
}

class _ExportScreenState extends State<ExportScreen> {
  @override
  void initState() {
    super.initState();

    context.read<MerchBloc>().add(MerchLoad());
    context.read<OrderBloc>().add(OrderLoad());
    context.read<PaymentMethodBloc>().add(PaymentMethodLoad());
    context.read<FestivalBloc>().add(FestivalLoad());
  }

  Export _exportMerch(List<Merch> merchList) async {
    List<List<dynamic>> table = [
      [
        'id',
        'name',
        'description',
        'price',
        'purchasePrice',
        'image',
        'categoryId',
      ],
      ...merchList.map(
        (merch) => [
          merch.id,
          merch.name,
          merch.description ?? '',
          merch.price.toString(),
          merch.purchasePrice.toString(),
          merch.thumbnail,
          merch.categoryId ?? '',
        ],
      ),
    ];

    return await _export(table: table, name: 'merch');
  }

  Export _exportOrders(List<Order> orderList) async {
    List<List<dynamic>> table = [
      [
        'id',
        'orderItems',
        'createdAt',
        'festival',
        'paymentMethod',
        'totalAmount',
      ],
      ...orderList.map(
        (order) => [
          order.id,
          jsonEncode(
            order.orderItems.map((orderItem) => orderItem.toJson()).toList(),
          ),
          order.createdAt.millisecondsSinceEpoch,
          order.festival.toJson(),
          order.paymentMethod.toJson(),
          order.totalEarned.toString(),
        ],
      ),
    ];

    return await _export(table: table, name: 'orders');
  }

  Export _exportPaymentMethods(List<PaymentMethod> paymentMethodList) async {
    List<List<dynamic>> table = [
      ['id', 'name', 'information', 'description', 'iconPath'],
      ...paymentMethodList.map(
        (paymentMethod) => [
          paymentMethod.id,
          paymentMethod.name,
          paymentMethod.information,
          paymentMethod.description ?? '',
          paymentMethod.iconPath ?? '',
        ],
      ),
    ];

    return await _export(table: table, name: 'payment-methods');
  }

  Export _exportFestivals(List<Festival> festivalList) async {
    List<List<dynamic>> table = [
      ['id', 'name', 'startDate', 'endDate'],
      ...festivalList.map(
        (festival) => [
          festival.id,
          festival.name,
          festival.startDate.millisecondsSinceEpoch,
          festival.endDate.millisecondsSinceEpoch,
        ],
      ),
    ];

    return await _export(table: table, name: 'festivals');
  }

  Export _export({
    required List<List<dynamic>> table,
    required String name,
  }) async {
    final csv = const ListToCsvConverter().convert(table);
    final bytes = utf8.encode(csv);
    final timestamp = DateTime.now().millisecondsSinceEpoch;

    final sb = StringBuffer();
    for (var row in table)
      sb.write('${row.toString().clampStringLength(500)}\n');
    GetIt.I<Talker>().debug(
      'Экспортирование файла "$name-export-$timestamp" со строками:\n${sb.toString()}',
    );

    return await FileSaver.instance.saveAs(
      name: '$name-export-$timestamp',
      bytes: bytes,
      fileExtension: 'csv',
      mimeType: MimeType.csv,
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

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          BaseSliverAppBar(title: S.of(context).dataExport),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            sliver: SliverList.list(
              children: [
                Text(
                  S.of(context).whatToExport,
                  style: theme.textTheme.headlineSmall,
                  textAlign: TextAlign.center,
                ),
                // SizedBox(height: 24),
                // ExportCard(
                //   onTap: () {},
                //   text: S.of(context).allAtOnce,
                //   icon: IconNames.puzzle,
                // ),
                const SizedBox(height: 12),
                Row(
                  spacing: 10,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BlocBuilder<MerchBloc, MerchState>(
                      builder: (context, state) {
                        return Expanded(
                          child: Skeletonizer(
                            enabled: state is! MerchLoaded,
                            ignoreContainers: true,
                            child: ExportCard(
                              onTap: state is MerchLoaded
                                  ? () async {
                                      final path = await _exportMerch(
                                        state.merchList,
                                      );
                                      if (path == null) return;
                                      if (!context.mounted) return;
                                      _showSuccessfullySavedDialog(
                                        context,
                                        path,
                                      );
                                    }
                                  : null,
                              text: S.of(context).merch,
                              icon: IconNames.cart,
                            ),
                          ),
                        );
                      },
                    ),
                    BlocBuilder<OrderBloc, OrderState>(
                      builder: (context, state) {
                        return Expanded(
                          child: Skeletonizer(
                            enabled: state is! OrderLoaded,
                            ignoreContainers: true,
                            child: ExportCard(
                              onTap: state is OrderLoaded
                                  ? () async {
                                      final path = await _exportOrders(
                                        state.orderList,
                                      );
                                      if (path == null) return;
                                      if (!context.mounted) return;
                                      _showSuccessfullySavedDialog(
                                        context,
                                        path,
                                      );
                                    }
                                  : null,
                              text: S.of(context).orderHistory,
                              icon: IconNames.history,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  spacing: 10,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BlocBuilder<PaymentMethodBloc, PaymentMethodState>(
                      builder: (context, state) {
                        return Expanded(
                          child: Skeletonizer(
                            enabled: state is! PaymentMethodLoaded,
                            ignoreContainers: true,
                            child: ExportCard(
                              onTap: state is PaymentMethodLoaded
                                  ? () async {
                                      final path = await _exportPaymentMethods(
                                        state.paymentMethodList,
                                      );
                                      if (path == null) return;
                                      if (!context.mounted) return;
                                      _showSuccessfullySavedDialog(
                                        context,
                                        path,
                                      );
                                    }
                                  : null,
                              text: S.of(context).paymentMethods,
                              icon: IconNames.money,
                            ),
                          ),
                        );
                      },
                    ),
                    BlocBuilder<FestivalBloc, FestivalState>(
                      builder: (context, state) {
                        return Expanded(
                          child: Skeletonizer(
                            enabled: state is! FestivalLoaded,
                            ignoreContainers: true,
                            child: ExportCard(
                              onTap: state is FestivalLoaded
                                  ? () async {
                                      final path = await _exportFestivals(
                                        state.festivalList,
                                      );
                                      if (path == null) return;
                                      if (!context.mounted) return;
                                      _showSuccessfullySavedDialog(
                                        context,
                                        path,
                                      );
                                    }
                                  : null,
                              text: S.of(context).festivals,
                              icon: IconNames.event,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

typedef Export = Future<String?>;
