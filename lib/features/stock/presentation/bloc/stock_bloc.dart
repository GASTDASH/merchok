import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merchok/features/orders/orders.dart';
import 'package:merchok/features/stock/stock.dart';
import 'package:merchok/generated/l10n.dart';

part 'stock_event.dart';
part 'stock_state.dart';

class StockBloc extends Bloc<StockEvent, StockState> {
  StockBloc({
    required StockRepository stockRepository,
    required OrderRepository orderRepository,
  }) : _stockRepository = stockRepository,
       _orderRepository = orderRepository,
       super(StockInitial()) {
    on<StockLoad>(_onStockLoad);
    on<StockAdd>(_onStockAdd);
    on<StockEdit>(_onStockEdit);
    on<StockDelete>(_onStockDelete);
    on<StockRecalculate>(_onStockRecalculate);
  }

  final OrderRepository _orderRepository;
  final StockRepository _stockRepository;

  Future<void> _onStockLoad(StockLoad event, Emitter<StockState> emit) async {
    try {
      if (event.festivalId == null) {
        emit(StockError(error: S.current.festivalNotSelected));
        return;
      }

      emit(const StockLoading(message: 'Загрузка информации о запасе'));

      final stockItems = await _stockRepository.getStockItems(
        festivalId: event.festivalId!,
      );

      // Получаем заказы только для текущего фестиваля
      final allOrders = await _orderRepository.getOrders();
      final festivalOrders = allOrders
          .where((order) => order.festival.id == event.festivalId)
          .toList();

      /// {merchId: остаток}
      final Map<String, int> remainders = {
        for (final item in stockItems) item.merchId: item.quantity,
      };

      // Вычитаем проданные товары из запасов только по заказам текущего фестиваля
      for (final order in festivalOrders) {
        for (final orderItem in order.orderItems) {
          remainders.update(
            orderItem.merch.id,
            (value) => value - orderItem.quantity,
            ifAbsent: () => 0,
          );
        }
      }

      emit(StockLoaded(stockItems: stockItems, remainders: remainders));
    } catch (e) {
      emit(StockError(error: e));
    }
  }

  Future<void> _onStockAdd(StockAdd event, Emitter<StockState> emit) async {
    try {
      emit(const StockLoading(message: 'Добавление в запас'));

      await _stockRepository.addStockItem(
        festivalId: event.festivalId,
        merchId: event.merchId,
      );

      add(StockLoad(festivalId: event.festivalId));
    } catch (e) {
      emit(StockError(error: e));
    }
  }

  Future<void> _onStockEdit(StockEdit event, Emitter<StockState> emit) async {
    try {
      emit(const StockLoading(message: 'Изменение запаса'));

      await _stockRepository.editStockItem(
        festivalId: event.festivalId,
        merchId: event.merchId,
        quantity: event.quantity,
      );

      add(StockLoad(festivalId: event.festivalId));
    } catch (e) {
      emit(StockError(error: e));
    }
  }

  Future<void> _onStockDelete(
    StockDelete event,
    Emitter<StockState> emit,
  ) async {
    try {
      emit(const StockLoading(message: 'Удаление из запаса'));

      await _stockRepository.deleteStockItem(
        festivalId: event.festivalId,
        merchId: event.merchId,
      );

      add(StockLoad(festivalId: event.festivalId));
    } catch (e) {
      emit(StockError(error: e));
    }
  }

  Future<void> _onStockRecalculate(
    StockRecalculate event,
    Emitter<StockState> emit,
  ) async => add(StockLoad(festivalId: event.festivalId));
}
