import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merchok/core/core.dart';
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
  const PaymentMethodStat({super.key, required this.orderList});

  final List<Order> orderList;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: BlocBuilder<PaymentMethodBloc, PaymentMethodState>(
        builder: (context, state) {
          late final Map<PaymentMethod, int>? paymentMethodCount;
          if (state is PaymentMethodLoaded) {
            paymentMethodCount = Map.fromEntries(
              state.paymentMethodList.map(
                (pm) => MapEntry(
                  pm,
                  orderList.where((o) => o.paymentMethod == pm).length,
                ),
              ),
            );
          } else {
            paymentMethodCount = null;
          }

          return ConstrainedBox(
            constraints: BoxConstraints(minHeight: 100),
            child: BaseContainer(
              elevation: 4,
              padding: EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                spacing: 24,
                children: [
                  FittedBox(
                    child: Text(
                      S.of(context).customerPreferences,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Builder(
                    builder: (context) {
                      if (state is PaymentMethodLoading) {
                        return SizedBox(
                          height: 200,
                          child: Skeletonizer(
                            enabled: true,
                            effect: PulseEffect(),
                            child: _PaymentMethodPieChart(
                              paymentMethodCount: paymentMethodCount,
                            ),
                          ),
                        );
                      } else if (paymentMethodCount != null) {
                        if (paymentMethodCount.isNotEmpty) {
                          return SizedBox(
                            height: 200,
                            child: _PaymentMethodPieChart(
                              paymentMethodCount: paymentMethodCount,
                            ),
                          );
                        } else {
                          return SizedBox(
                            height: 30,
                            child: FittedBox(
                              child: Text(S.of(context).notEnoughData),
                            ),
                          );
                        }
                      } else if (paymentMethodCount == null) {
                        return Expanded(child: Container(color: Colors.red));
                      } else if (state is PaymentMethodError) {
                        return Text(S.of(context).errorLoadingPaymentMethods);
                      } else if (state is PaymentMethodInitial) {
                        return SizedBox.shrink();
                      }
                      return Text(S.of(context).unexpectedState);
                    },
                  ),
                  Builder(
                    builder: (context) {
                      if (paymentMethodCount != null) {
                        return Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: List.generate(paymentMethodCount.length, (
                            i,
                          ) {
                            final paymentMethod = paymentMethodCount!.keys
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
              ),
            ),
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
