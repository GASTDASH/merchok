import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'stock_item.g.dart';

@HiveType(typeId: 6)
class StockItem extends Equatable {
  const StockItem({
    required this.merchId,
    required this.quantity,
    required this.festivalId,
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

  @override
  List<Object?> get props => [merchId, quantity];

  StockItem copyWith({String? merchId, int? quantity, String? festivalId}) {
    return StockItem(
      merchId: merchId ?? this.merchId,
      quantity: quantity ?? this.quantity,
      festivalId: festivalId ?? this.festivalId,
    );
  }
}
