import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:merchok/core/core.dart';
import 'package:merchok/generated/l10n.dart';

class EditPaymentMethodDialog extends StatefulWidget {
  const EditPaymentMethodDialog({super.key});

  @override
  State<EditPaymentMethodDialog> createState() =>
      _EditPaymentMethodDialogState();
}

class _EditPaymentMethodDialogState extends State<EditPaymentMethodDialog> {
  String? selectedIcon;

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
              Row(
                spacing: 12,
                children: [
                  Text(
                    '${S.of(context).icon}:',
                    style: theme.textTheme.titleMedium,
                  ),
                  SizedBox(
                    width: 64,
                    child: DropdownButtonFormField(
                      initialValue: selectedIcon,
                      items: [
                        DropdownMenuItem(value: null, child: SizedBox.shrink()),
                        DropdownMenuItem(
                          value: IconNames.money,
                          child: SvgPicture.asset(IconNames.money),
                        ),
                        DropdownMenuItem(
                          value: IconNames.alfabank,
                          child: SvgPicture.asset(IconNames.alfabank),
                        ),
                        DropdownMenuItem(
                          value: IconNames.sberbank,
                          child: SvgPicture.asset(IconNames.sberbank),
                        ),
                        DropdownMenuItem(
                          value: IconNames.tbank,
                          child: SvgPicture.asset(IconNames.tbank),
                        ),
                        DropdownMenuItem(
                          value: IconNames.vtb,
                          child: SvgPicture.asset(IconNames.vtb),
                        ),
                        DropdownMenuItem(
                          value: IconNames.yoomoney,
                          child: SvgPicture.asset(IconNames.yoomoney),
                        ),
                      ],
                      onChanged: (value) {},
                    ),
                  ),
                ],
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
