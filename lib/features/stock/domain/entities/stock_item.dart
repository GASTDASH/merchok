import 'package:equatable/equatable.dart';
import 'package:hive_ce/hive_ce.dart';

part 'stock_item.g.dart';

@HiveType(typeId: 6)
class StockItem extends Equatable {
  const StockItem({
    required this.merchId,
    required this.quantity,
    required this.festivalId,
    required this.purchasePrice,
  });

  /// Id фестиваля
  @HiveField(0)
  final String festivalId;

  /// Id мерча
  @HiveField(1)
  final String merchId;

  /// Количество привезённого товара
  @HiveField(2)
  final int quantity;

  /// Цена закупки на момент создания (привоза)
  @HiveField(3)
  final double? purchasePrice;

  @override
  List<Object?> get props => [merchId, quantity];

  StockItem copyWith({
    String? merchId,
    int? quantity,
    String? festivalId,
    double? purchasePrice,
  }) {
    return StockItem(
      merchId: merchId ?? this.merchId,
      quantity: quantity ?? this.quantity,
      festivalId: festivalId ?? this.festivalId,
      purchasePrice: purchasePrice ?? this.purchasePrice,
    );
  }
}
