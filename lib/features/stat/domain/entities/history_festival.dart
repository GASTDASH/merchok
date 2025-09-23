import 'package:equatable/equatable.dart';
import 'package:merchok/features/festival/festival.dart';

class HistoryFestival extends Equatable {
  const HistoryFestival({
    required this.festival,
    required this.totalEarned,
    required this.orderCount,
    required this.salesCount,
    required this.revenue,
  });

  final Festival festival;
  final int orderCount;
  final int salesCount;
  final double totalEarned;
  final double revenue;

  @override
  List<Object?> get props => [festival, orderCount, salesCount, totalEarned];
}
