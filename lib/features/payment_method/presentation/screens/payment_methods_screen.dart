import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:merchok/core/core.dart';
import 'package:merchok/features/payment_method/payment_method.dart';
import 'package:merchok/generated/l10n.dart';

class PaymentMethodsScreen extends StatelessWidget {
  const PaymentMethodsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          BaseSliverAppBar(
            title: S.of(context).paymentMethods,
            actions: [
              IconButton(
                onPressed: () {},
                icon: SvgPicture.asset(
                  IconNames.add,
                  colorFilter: ColorFilter.mode(
                    theme.colorScheme.onSurface,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ],
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            sliver: SliverList.builder(
              itemCount: 5,
              itemBuilder: (context, index) => PaymentMethodCard(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => EditPaymentMethodDialog(),
                  );
                },
                title: 'Сбербанк',
                subtitle: '+7 (916) 990 68-64',
                description: 'Алексей Вадимович Щ.',
                icon: IconNames.sberbank,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

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
              Text('Название *', style: theme.textTheme.titleMedium),
              TextFormField(
                validator: (value) =>
                    value!.isEmpty ? 'Введите название' : null,
              ),
              SizedBox(height: 24),
              Text('Информация *', style: theme.textTheme.titleMedium),
              TextFormField(
                validator: (value) =>
                    value!.isEmpty ? 'Введите информацию' : null,
              ),
              SizedBox(height: 24),
              Text('Доп. информация', style: theme.textTheme.titleMedium),
              TextFormField(),
              SizedBox(height: 24),
              BaseButton(
                onTap: () {
                  context.pop();
                },
                child: Text('Сохранить'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
