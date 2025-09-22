import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merchok/features/orders/orders.dart';
import 'package:merchok/features/payment_method/payment_method.dart';
import 'package:merchok/features/stat/stat.dart';
import 'package:merchok/generated/l10n.dart';
import 'package:skeletonizer/skeletonizer.dart';

Color _genColorBy(PaymentMethod paymentMethod) {
  final int hash = paymentMethod.name.hashCode;
  double hue = (hash % 360).toDouble();
  return HSLColor.fromAHSL(1.0, hue, 0.8, 0.6).toColor();
}

class PaymentMethodStat extends StatelessWidget {
  const PaymentMethodStat({super.key, this.orderList});

  final List<Order>? orderList;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: BlocBuilder<PaymentMethodBloc, PaymentMethodState>(
        builder: (context, state) {
          final Map<PaymentMethod, int>? paymentMethodCount =
              orderList != null && state is PaymentMethodLoaded
              ? Map.fromEntries(
                  state.paymentMethodList.map(
                    (pm) => MapEntry(
                      pm,
                      orderList!.where((o) => o.paymentMethod == pm).length,
                    ),
                  ),
                )
              : null;

          return Column(
            children: [
              SizedBox(
                height: 200,
                child: Builder(
                  builder: (context) {
                    if (state is PaymentMethodLoading ||
                        paymentMethodCount != null) {
                      return Skeletonizer(
                        enabled:
                            state is PaymentMethodLoading ||
                            paymentMethodCount == null,
                        effect: PulseEffect(),
                        child: _PaymentMethodPieChart(
                          paymentMethodCount: paymentMethodCount,
                        ),
                      );
                    } else if (state is PaymentMethodError) {
                      Text(S.of(context).errorLoadingPaymentMethods);
                    } else if (state is PaymentMethodInitial) {
                      return SizedBox.shrink();
                    }
                    return SizedBox.shrink();
                  },
                ),
              ),
              const SizedBox(height: 24),
              Builder(
                builder: (context) {
                  if (paymentMethodCount != null) {
                    return Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: List.generate(paymentMethodCount.length, (i) {
                        final paymentMethod = paymentMethodCount.keys
                            .toList()[i];
                        return Indicator(
                          text: paymentMethod.name,
                          color: _genColorBy(paymentMethod),
                        );
                      }),
                    );
                  } else {
                    return SizedBox.shrink();
                  }
                },
              ),
            ],
          );
        },
      ),
    );
  }
}

class _PaymentMethodPieChart extends StatelessWidget {
  const _PaymentMethodPieChart({this.paymentMethodCount});

  final Map<PaymentMethod, int>? paymentMethodCount;

  @override
  Widget build(BuildContext context) {
    if (paymentMethodCount == null) return PieChart(_DefaultPieChartData());
    return PieChart(
      PieChartData(
        sections: List.generate(paymentMethodCount!.length, (i) {
          final paymentMethod = paymentMethodCount!.keys.toList()[i];
          return PieChartSectionData(
            value: paymentMethodCount![paymentMethod]!.toDouble(),
            badgeWidget: Text(
              '${paymentMethodCount![paymentMethod]}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            showTitle: false,
            color: _genColorBy(paymentMethod),
            radius: 50,
            titleStyle: Theme.of(context).textTheme.titleMedium,
          );
        }),
      ),
    );
  }
}

class _DefaultPieChartData extends PieChartData {
  _DefaultPieChartData()
    : super(
        sections: [
          PieChartSectionData(
            value: 999,
            color: Colors.grey.shade300,
            radius: 50,
          ),
          PieChartSectionData(
            value: 666,
            color: Colors.grey.shade300,
            radius: 50,
          ),
          PieChartSectionData(
            value: 444,
            color: Colors.grey.shade300,
            radius: 50,
          ),
        ],
      );
}
