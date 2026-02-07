import 'package:merchok/features/stock/stock.dart';

class StockRepositoryImpl implements StockRepository {
  // Map<festivalId, Map<merchId, StockItem>>
  //
  // {
  //   festival1: {
  //     merchId1: StockItem(merchId: merchId1, quantity: 1),
  //     merchId2: StockItem(merchId: merchId2, quantity: 2),
  //   }
  //   festival2: {
  //     merchId2: StockItem(merchId: merchId2, quantity: 1),
  //     merchId3: StockItem(merchId: merchId3, quantity: 2),
  //   }
  // }
  final Map<String, Map<String, StockItem>> _stockItems = {};

  @override
  Future<List<StockItem>> getStockItems({required String festivalId}) async =>
      _stockItems[festivalId]?.values.toList() ?? [];

  @override
  Future<void> addStockItem({
    required String festivalId,
    required String merchId,
  }) async {
    // Запас фестиваля
    final festivalStock = _stockItems[festivalId] ??= {};
    final stockItem = festivalStock[merchId];

    // Если товар уже есть в запасе фестиваля
    if (stockItem != null) {
      festivalStock[merchId] = stockItem.copyWith(
        quantity: stockItem.quantity + 1,
      );
    }
    // Если товара нет в запасе фестиваля
    else {
      festivalStock[merchId] = StockItem(
        merchId: merchId,
        festivalId: festivalId,
        quantity: 1,
      );
    }

    _stockItems[festivalId] = festivalStock;
  }

  @override
  Future<void> editStockItem({
    required String merchId,
    required String festivalId,
    required int quantity,
  }) async {
    final festivalStock = _stockItems[festivalId] ??= {};

    festivalStock[merchId] = StockItem(
      merchId: merchId,
      festivalId: festivalId,
      quantity: quantity,
    );
  }

  @override
  Future<void> deleteStockItem({
    required String festivalId,
    required String merchId,
  }) async => _stockItems[festivalId]?.remove(merchId);
}
