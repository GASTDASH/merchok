import 'package:merchok/features/stock/stock.dart';

class StockRepositoryImpl implements StockRepository {
  final Map<String, StockItem> stockItems = {};

  @override
  Future<List<StockItem>> getStockItems() async => stockItems.values.toList();

  @override
  Future<void> addStockItem(String merchId) async {
    final stockItem = stockItems[merchId];
    if (stockItem != null) {
      return stockItems.addAll({
        merchId: StockItem(merchId: merchId, quantity: stockItem.quantity + 1),
      });
    }
    return stockItems.addAll({
      merchId: StockItem(merchId: merchId, quantity: 1),
    });
  }

  @override
  Future<void> editStockItem(String merchId, int quantity) async => stockItems
      .addAll({merchId: StockItem(merchId: merchId, quantity: quantity)});

  @override
  Future<void> deleteStockItem(String merchId) async =>
      stockItems.remove(merchId);
}
