import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:merchok/core/core.dart';
import 'package:merchok/generated/l10n.dart';

class EditDialog extends StatefulWidget {
  const EditDialog({super.key, required this.previous, required this.hintText});

  final String previous;
  final String hintText;

  @override
  State<EditDialog> createState() => _EditDialogState();
}

class _EditDialogState extends State<EditDialog> {
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();

    controller.text = widget.previous;
  }

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
                    decoration: InputDecoration(hintText: widget.hintText),
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
                  child: Text(S.of(context).save),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<String> showEditDialog({
  required BuildContext context,
  required String previous,
  required String hintText,
}) async => await showDialog(
  context: context,
  builder: (context) => EditDialog(previous: previous, hintText: hintText),
);
