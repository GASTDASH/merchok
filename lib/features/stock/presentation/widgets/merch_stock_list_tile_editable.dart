import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:merchok/core/core.dart';
import 'package:merchok/features/current_festival/current_festival.dart';
import 'package:merchok/features/festival/festival.dart';
import 'package:merchok/features/merch/merch.dart';
import 'package:merchok/features/stock/stock.dart';

class MerchStockListTileEditable extends StatefulWidget {
  const MerchStockListTileEditable({
    super.key,
    required this.merch,
    required this.stockItem,
    this.remainder,
  });

  final Merch merch;
  final int? remainder;
  final StockItem stockItem;

  @override
  State<MerchStockListTileEditable> createState() =>
      _MerchStockListTileEditableState();
}

class _MerchStockListTileEditableState
    extends State<MerchStockListTileEditable> {
  late final TextEditingController quantityController;

  void saveValue({required String value, required String festivalId}) {
    final int? quantity = int.tryParse(value);

    if (quantity != null) {
      FocusManager.instance.primaryFocus?.unfocus();
      context.read<StockBloc>().add(
        StockEdit(
          merchId: widget.stockItem.merchId,
          quantity: quantity,
          festivalId: festivalId,
        ),
      );
    } else {
      Fluttertoast.showToast(msg: 'Введите корректное количество');
    }
  }

  @override
  void initState() {
    super.initState();

    quantityController = TextEditingController(
      text: widget.stockItem.quantity.toString(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          BlocBuilder<CurrentFestivalCubit, Festival?>(
            builder: (context, currentFestival) {
              return Row(
                children: [
                  Expanded(
                    child: MerchStockListTile(
                      merch: widget.merch,
                      onLongPress: () {
                        showYesNoDialog(
                          context: context,
                          message: 'Удалить мерч из запаса?',
                          onYes: () {
                            context.read<StockBloc>().add(
                              StockDelete(
                                merchId: widget.stockItem.merchId,
                                festivalId: currentFestival!.id,
                              ),
                            );
                            context.pop();
                          },
                          onNo: () => context.pop(),
                        );
                      },
                    ),
                  ),
                  Column(
                    spacing: 4,
                    children: [
                      const Text('Привезено:'),
                      SizedBox(
                        width: 80,
                        child: TextField(
                          controller: quantityController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                          onTapOutside: (_) => saveValue(
                            value: quantityController.text,
                            festivalId: currentFestival!.id,
                          ),
                          onSubmitted: (value) => saveValue(
                            value: value,
                            festivalId: currentFestival!.id,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
          Text(
            'Остаток: ${widget.remainder}',
            style: theme.textTheme.titleLarge,
          ),
        ],
      ),
    );
  }
}
