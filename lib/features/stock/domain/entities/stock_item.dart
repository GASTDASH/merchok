// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class StockItem extends Equatable {
  const StockItem({
    required this.merchId,
    required this.quantity,
    required this.festivalId,
  });

  final String festivalId;
  final String merchId;

  /// Количество привезённого товара
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
