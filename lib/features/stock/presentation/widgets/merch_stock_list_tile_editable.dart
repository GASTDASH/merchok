import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:merchok/core/core.dart';
import 'package:merchok/features/merch/merch.dart';
import 'package:merchok/features/stock/stock.dart';

class MerchStockListTileEditable extends StatefulWidget {
  const MerchStockListTileEditable({
    super.key,
    required this.merch,
    required this.stockItem,
  });

  final Merch merch;
  final StockItem stockItem;

  @override
  State<MerchStockListTileEditable> createState() =>
      _MerchStockListTileEditableState();
}

class _MerchStockListTileEditableState
    extends State<MerchStockListTileEditable> {
  late final TextEditingController quantityController;

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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
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
                        StockDelete(merchId: widget.stockItem.merchId),
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
                const Text('Привоз:'),
                SizedBox(
                  width: 80,
                  child: TextField(
                    controller: quantityController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    onTapOutside: (_) {
                      FocusManager.instance.primaryFocus?.unfocus();
                      context.read<StockBloc>().add(
                        StockEdit(
                          merchId: widget.stockItem.merchId,
                          quantity: int.tryParse(quantityController.text) ?? 0,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
        Text('Остаток: ', style: theme.textTheme.titleLarge),
      ],
    );
  }
}
