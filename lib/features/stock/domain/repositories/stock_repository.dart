import 'package:merchok/features/stock/stock.dart';

abstract interface class StockRepository {
  Future<List<StockItem>> getStockItems({required String festivalId});
  Future<void> addStockItem({
    required String festivalId,
    required String merchId,
  });
  Future<void> editStockItem({
    required String festivalId,
    required String merchId,
    required int quantity,
  });
  Future<void> deleteStockItem({
    required String festivalId,
    required String merchId,
  });
}
