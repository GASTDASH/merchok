import 'package:equatable/equatable.dart';
import 'package:merchok/features/festival/festival.dart';

class HistoryFestival extends Equatable {
  const HistoryFestival({
    required this.festival,
    required this.totalEarned,
    required this.ordersCount,
    required this.salesCount,
    required this.revenue,
  });

  final Festival festival;
  final int ordersCount;
  final int salesCount;
  final double totalEarned;
  final double revenue;

  @override
  List<Object?> get props => [festival, ordersCount, salesCount, totalEarned];
}
