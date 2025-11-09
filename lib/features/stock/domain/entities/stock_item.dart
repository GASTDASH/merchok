// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class StockItem extends Equatable {
  const StockItem({required this.merchId, required this.quantity});

  final String merchId;
  final int quantity;

  @override
  List<Object?> get props => [merchId, quantity];

  StockItem copyWith({String? merchId, int? quantity}) {
    return StockItem(
      merchId: merchId ?? this.merchId,
      quantity: quantity ?? this.quantity,
    );
  }
}
