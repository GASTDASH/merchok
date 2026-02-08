import 'package:flutter/material.dart';
import 'package:merchok/core/core.dart';
import 'package:merchok/features/merch/merch.dart';
import 'package:merchok/generated/l10n.dart';

class MerchStockListTile extends StatelessWidget {
  const MerchStockListTile({
    super.key,
    required this.merch,
    this.onTap,
    this.onLongPress,
  });

  final Merch merch;
  final VoidCallback? onLongPress;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      onLongPress: onLongPress,
      title: Text(merch.name, style: Theme.of(context).textTheme.titleLarge),
      subtitle: Text(
        '${S.of(context).sell}: ${merch.price.truncateIfInt()} ₽ | ${S.of(context).cost}: ${merch.purchasePrice?.truncateIfInt() ?? '0'} ₽',
      ),
    );
  }
}
