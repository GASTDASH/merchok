import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:merchok/core/core.dart';
import 'package:merchok/generated/l10n.dart';

class EditPaymentMethodDialog extends StatelessWidget {
  const EditPaymentMethodDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Dialog(
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Form(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${S.of(context).title} *',
                style: theme.textTheme.titleMedium,
              ),
              TextFormField(
                validator: (value) =>
                    value!.isEmpty ? S.of(context).enterTitle : null,
              ),
              SizedBox(height: 24),
              Text(
                '${S.of(context).information} *',
                style: theme.textTheme.titleMedium,
              ),
              TextFormField(
                validator: (value) =>
                    value!.isEmpty ? S.of(context).enterInformation : null,
              ),
              SizedBox(height: 24),
              Text(
                S.of(context).additionalInformation,
                style: theme.textTheme.titleMedium,
              ),
              TextFormField(),
              SizedBox(height: 24),
              BaseButton(
                onTap: () {
                  context.pop();
                },
                child: Text(S.of(context).save),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
