import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:merchok/core/core.dart';
import 'package:merchok/generated/l10n.dart';

class AddDialog extends StatelessWidget {
  const AddDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          spacing: 24,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              style: theme.textTheme.bodyLarge,
              decoration: InputDecoration(hintText: S.of(context).enterName),
            ),
            Align(
              alignment: AlignmentGeometry.centerRight,
              child: FittedBox(
                child: BaseButton(
                  onTap: () {
                    context.pop();
                  },
                  child: Text(S.of(context).add),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<dynamic> showAddDialog(BuildContext context) =>
    showDialog(context: context, builder: (context) => AddDialog());
