import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:merchok/core/core.dart';
import 'package:merchok/features/festival/festival.dart';
import 'package:merchok/generated/l10n.dart';

class EditFestivalDialog extends StatefulWidget {
  const EditFestivalDialog({super.key, required this.previousFestival});

  final Festival previousFestival;

  @override
  State<EditFestivalDialog> createState() => _EditFestivalDialogState();
}

class _EditFestivalDialogState extends State<EditFestivalDialog> {
  late DateTime endDate;
  final TextEditingController nameController = TextEditingController();
  late DateTime startDate;

  @override
  void initState() {
    super.initState();

    startDate = widget.previousFestival.startDate;
    endDate = widget.previousFestival.endDate;

    nameController.text = widget.previousFestival.name;
  }

  Future<DateTime?> changeDateDialog({
    required BuildContext context,
    DateTime? previousDateTime,
  }) async {
    return await showDatePicker(
      context: context,
      firstDate: DateTime(2024),
      lastDate: DateTime.now().add(Duration(days: 200)),
      currentDate: previousDateTime,
    );
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
                    controller: nameController,
                    style: theme.textTheme.bodyLarge,
                    decoration: InputDecoration(
                      hintText: S.of(context).enterName,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => nameController.text = '',
                  icon: Icon(Icons.backspace_outlined),
                ),
              ],
            ),
            Row(
              spacing: 8,
              children: [
                Expanded(
                  child: _DateButton(
                    text: startDate.toCompactString(),
                    onTap: () async {
                      final newDate = await changeDateDialog(
                        context: context,
                        previousDateTime: startDate,
                      );
                      if (newDate == null) return;

                      setState(() => startDate = newDate);
                    },
                  ),
                ),
                BaseSvgIcon(context, IconNames.right),
                Expanded(
                  child: _DateButton(
                    text: endDate.toCompactString(),
                    onTap: () async {
                      final newDate = await changeDateDialog(
                        context: context,
                        previousDateTime: endDate,
                      );
                      if (newDate == null) return;

                      setState(() => endDate = newDate);
                    },
                  ),
                ),
              ],
            ),
            Align(
              alignment: AlignmentGeometry.centerRight,
              child: FittedBox(
                child: BaseButton(
                  onTap: () => context.pop(
                    widget.previousFestival.copyWith(
                      name: nameController.text.isNotEmpty
                          ? nameController.text
                          : S.of(context).untitled,
                      startDate: startDate,
                      endDate: endDate,
                    ),
                  ),
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

class _DateButton extends StatelessWidget {
  const _DateButton({required this.text, required this.onTap});

  final VoidCallback onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    return BaseContainer(
      onTap: onTap,
      padding: EdgeInsets.all(8),
      elevation: 4,
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyLarge,
        textAlign: TextAlign.center,
      ),
    );
  }
}
