import 'package:hive/hive.dart';
import 'package:merchok/core/core.dart';
import 'package:merchok/features/stock/stock.dart';

class StockRepositoryImpl implements StockRepository {
  /// ### Map\<festivalId, Map\<merchId, StockItem>>
  ///
  ///  - festival1:
  ///    + merchId1: StockItem(merchId: merchId1, quantity: 1),
  ///    + merchId2: StockItem(merchId: merchId2, quantity: 2),<br/>
  ///  - festival2:
  ///    + merchId2: StockItem(merchId: merchId2, quantity: 1),
  ///    + merchId3: StockItem(merchId: merchId3, quantity: 2),<br/>
  // final Map<String, Map<String, StockItem>> _stockItems = {};
  final Box<Map> _stockItemsBox = Hive.box<Map>(HiveBoxesNames.stock);

  /// Вспомогательный метод для безопасного приведения типов
  Map<String, StockItem> _getTypedMap(String festivalId) {
    final raw = _stockItemsBox.get(festivalId);
    if (raw == null) return <String, StockItem>{};

    // Преобразуем Map<dynamic, dynamic> в Map<String, StockItem>
    return Map<String, StockItem>.from(
      raw.map((k, v) => MapEntry(k as String, v as StockItem)),
    );
  }

  /// Получает список товаров в запасе фестиваля с указанным [festivalId]
  @override
  Future<List<StockItem>> getStockItems({required String festivalId}) async {
    final rawMap = _stockItemsBox.get(festivalId);
    if (rawMap == null) return [];

    return rawMap.values.cast<StockItem>().toList();
  }

  /// Добавляет товар с указанным [merchId] и в запас фестиваля с указанным [festivalId]
  @override
  Future<void> addStockItem({
    required String festivalId,
    required String merchId,
  }) async {
    // Запас фестиваля
    final festivalStock = _getTypedMap(festivalId);
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

    _stockItemsBox.put(festivalId, festivalStock);
  }

  /// Изменяет количество [quantity] товара с указанным [merchId] в запасе фестиваля с указанным [festivalId]
  @override
  Future<void> editStockItem({
    required String merchId,
    required String festivalId,
    required int quantity,
  }) async {
    final festivalStock = _getTypedMap(festivalId);

    festivalStock[merchId] = StockItem(
      merchId: merchId,
      festivalId: festivalId,
      quantity: quantity,
    );

    _stockItemsBox.put(festivalId, festivalStock);
  }

  /// Удаляет товар с указанным [merchId] из запаса фестиваля с указанным [festivalId]
  @override
  Future<void> deleteStockItem({
    required String festivalId,
    required String merchId,
  }) async {
    final festivalStock = _getTypedMap(festivalId);

    if (festivalStock.containsKey(merchId)) {
      festivalStock.remove(merchId);
    }

    _stockItemsBox.put(festivalId, festivalStock);
  }
}
