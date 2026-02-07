import 'package:merchok/features/stock/stock.dart';

abstract interface class StockRepository {
  Future<List<StockItem>> getStockItems();
  Future<void> addStockItem(String merchId);
  Future<void> editStockItem(String merchId, int quantity);
  Future<void> deleteStockItem(String merchId);
}
