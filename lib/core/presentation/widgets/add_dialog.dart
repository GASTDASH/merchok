import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:merchok/core/core.dart';
import 'package:merchok/generated/l10n.dart';

class AddDialog extends StatefulWidget {
  const AddDialog({super.key});

  @override
  State<AddDialog> createState() => _AddDialogState();
}

class _AddDialogState extends State<AddDialog> {
  final TextEditingController controller = TextEditingController(
    text: 'Без названия',
  );

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
            Row(
              spacing: 8,
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    style: theme.textTheme.bodyLarge,
                    decoration: InputDecoration(
                      hintText: S.of(context).enterName,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => controller.text = '',
                  icon: Icon(Icons.backspace_outlined),
                ),
              ],
            ),
            Align(
              alignment: AlignmentGeometry.centerRight,
              child: FittedBox(
                child: BaseButton(
                  onTap: () => context.pop(controller.text),
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

Future<String?> showAddDialog(BuildContext context) async =>
    await showDialog(context: context, builder: (context) => AddDialog());
