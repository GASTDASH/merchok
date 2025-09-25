import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:merchok/core/core.dart';
import 'package:merchok/features/payment_method/payment_method.dart';
import 'package:merchok/generated/l10n.dart';

class PaymentMethodsScreen extends StatefulWidget {
  const PaymentMethodsScreen({super.key});

  @override
  State<PaymentMethodsScreen> createState() => _PaymentMethodsScreenState();
}

class _PaymentMethodsScreenState extends State<PaymentMethodsScreen> {
  @override
  void initState() {
    super.initState();

    context.read<PaymentMethodBloc>().add(PaymentMethodLoad());
  }

  Future<void> deletePaymentMethod(
    BuildContext context,
    String paymentMethodId,
  ) async => await showDeleteDialog(
    context: context,
    message: S.of(context).deleteThisPaymentMethod,
    onNo: () => context.pop(),
    onYes: () {
      context.pop();
      context.read<PaymentMethodBloc>().add(
        PaymentMethodDelete(paymentMethodId: paymentMethodId),
      );
    },
  );

  Future<void> addPaymentMethod(BuildContext context) async {
    final bloc = context.read<PaymentMethodBloc>();

    final paymentMethod = await showDialog(
      context: context,
      builder: (context) => EditPaymentMethodDialog(),
    );
    if (paymentMethod == null) return;

    bloc.add(PaymentMethodAdd(paymentMethod: paymentMethod));
  }

  Future<void> editPaymentMethod(
    BuildContext context, [
    PaymentMethod? previousPaymentMethod,
  ]) async {
    final bloc = context.read<PaymentMethodBloc>();

    final paymentMethod = await await showDialog(
      context: context,
      builder: (context) =>
          EditPaymentMethodDialog(previousPaymentMethod: previousPaymentMethod),
    );
    if (paymentMethod == null) return;

    bloc.add(PaymentMethodEdit(paymentMethod: paymentMethod));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          BaseSliverAppBar(
            title: S.of(context).paymentMethods,
            actions: [
              IconButton(
                onPressed: () async => await addPaymentMethod(context),
                icon: Icon(AppIcons.add),
              ),
            ],
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            sliver: BlocBuilder<PaymentMethodBloc, PaymentMethodState>(
              builder: (context, state) {
                if (state is PaymentMethodLoading) {
                  return LoadingBanner();
                } else if (state is PaymentMethodLoaded) {
                  if (state.paymentMethodList.isNotEmpty) {
                    return SliverList.builder(
                      itemCount: state.paymentMethodList.length,
                      itemBuilder: (context, index) {
                        final paymentMethod = state.paymentMethodList[index];
                        return PaymentMethodCard(
                          paymentMethod: paymentMethod,
                          onTapEdit: () async =>
                              await editPaymentMethod(context, paymentMethod),
                          onLongPress: () async => await deletePaymentMethod(
                            context,
                            paymentMethod.id,
                          ),
                        );
                      },
                    );
                  } else {
                    return InfoBanner(
                      text: S.of(context).addYourFirstPaymentMethod,
                    );
                  }
                } else if (state is PaymentMethodError) {
                  return ErrorBanner(message: state.error.toString());
                } else if (state is PaymentMethodInitial) {
                  return SliverFillRemaining();
                }
                return UnexpectedStateBanner();
              },
            ),
          ),
        ],
      ),
    );
  }
}
