import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merchok/core/core.dart';
import 'package:merchok/features/current_festival/current_festival.dart';
import 'package:merchok/features/festival/festival.dart';
import 'package:merchok/features/merch/merch.dart';
import 'package:merchok/features/stock/stock.dart';
import 'package:merchok/generated/l10n.dart';

class StockScreen extends StatelessWidget {
  const StockScreen({super.key});

  Future<void> _addMerch(
    BuildContext context, {
    required List<Merch> merchList,
    required List<StockItem> stockItems,
    required String festivalId,
  }) async {
    final stockBloc = context.read<StockBloc>();

    final merch = await _showSelectMerchBottomSheet(
      context,
      merchList,
      stockItems,
    );

    if (merch == null || merch is! Merch) return;

    stockBloc.add(StockAdd(festivalId: festivalId, merchId: merch.id));
  }

  Future<dynamic> _showSelectMerchBottomSheet(
    BuildContext context,
    List<Merch> merchList,
    List<StockItem> stockItems,
  ) {
    return showBaseDraggableBottomSheet(
      context: context,
      builder: (context) => SelectMerchBottomSheet(
        merchList: merchList.toList()
          ..removeWhere(
            (merch) => stockItems.any((item) => item.merchId == merch.id),
          ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          BlocBuilder<CurrentFestivalCubit, Festival?>(
            builder: (context, currentFestival) {
              if (currentFestival == null) {
                return const InfoBanner.icon(
                  text: 'Выберите фестиваль для управления запасами',
                  icon: AppIcons.cube,
                );
              }

              return BlocBuilder<MerchBloc, MerchState>(
                builder: (context, merchState) {
                  return BlocBuilder<StockBloc, StockState>(
                    builder: (context, stockState) {
                      return SliverMainAxisGroup(
                        slivers: [
                          BaseSliverAppBar(
                            title: 'Запас: ${currentFestival.name}',
                            actions: [
                              IconButton(
                                onPressed:
                                    merchState is MerchLoaded &&
                                        stockState is StockLoaded
                                    ? () async => await _addMerch(
                                        context,
                                        merchList: merchState.merchList,
                                        stockItems: stockState.stockItems,
                                        festivalId: currentFestival.id,
                                      )
                                    : null,
                                icon: const Icon(AppIcons.add),
                              ),
                            ],
                          ),
                          SliverToBoxAdapter(
                            child: Container(
                              margin: const EdgeInsets.all(16),
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: theme.colorScheme.error.withValues(
                                    green: theme.colorScheme.error.g / 1.5,
                                    blue: theme.colorScheme.error.g / 1.5,
                                  ),
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Text(
                                'Пожалуйста, внимательно считайте кол-во привезённого мерча для предотвращения возникновения проблем с изменением уже купленных позиций!',
                                style: theme.textTheme.bodyLarge,
                              ),
                            ),
                          ),
                          _StockList(
                            merchState: merchState,
                            stockState: stockState,
                          ),
                        ],
                      );
                    },
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

class _StockList extends StatelessWidget {
  const _StockList({required this.merchState, required this.stockState});

  final MerchState merchState;
  final StockState stockState;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        if (merchState is MerchLoaded && stockState is StockLoaded) {
          if ((stockState as StockLoaded).stockItems.isEmpty) {
            return const InfoBanner.icon(
              text: 'Здесь будут ваш запас мерча',
              icon: AppIcons.cube,
            );
          } else {
            return SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverList.separated(
                itemCount: (stockState as StockLoaded).stockItems.length,
                itemBuilder: (context, index) {
                  final stockItem =
                      (stockState as StockLoaded).stockItems[index];
                  final merch = (merchState as MerchLoaded).merchList
                      .firstWhere((merch) {
                        return merch.id == stockItem.merchId;
                      });
                  final remainder = (stockState as StockLoaded).remainders;

                  return MerchStockListTileEditable(
                    merch: merch,
                    stockItem: stockItem,
                    remainder: remainder[merch.id],
                  );
                },
                separatorBuilder: (context, index) => const Divider(),
              ),
            );
          }
        }
        if (merchState is MerchLoading || stockState is StockLoading) {
          return const LoadingBanner();
        }
        return InfoBanner(text: S.of(context).merchIsNotLoaded);
      },
    );
  }
}
