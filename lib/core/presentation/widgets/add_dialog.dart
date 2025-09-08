import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:merchok/core/core.dart';

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
              decoration: InputDecoration(hintText: 'Введите имя'),
            ),
            Align(
              alignment: AlignmentGeometry.centerRight,
              child: FittedBox(
                child: BaseButton(
                  onTap: () {
                    context.pop();
                  },
                  child: Text(
                    'Добавить',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
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
