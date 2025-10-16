import 'package:flutter/material.dart';

class NotFoundDialog extends StatelessWidget {
  const NotFoundDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          spacing: 16,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.qr_code_rounded, size: 48),
            Text(
              'Отсканированный мерч не найден',
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const Text(
              'Попробуйте ещё раз, или, возможно, у вас нет этого мерча',
            ),
          ],
        ),
      ),
    );
  }
}
