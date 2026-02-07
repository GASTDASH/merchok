import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merchok/features/orders/orders.dart';
import 'package:merchok/features/stock/stock.dart';

part 'stock_event.dart';
part 'stock_state.dart';

class StockBloc extends Bloc<StockEvent, StockState> {
  final StockRepository _stockRepository;
  final OrderRepository _orderRepository;

  StockBloc({
    required StockRepository stockRepository,
    required OrderRepository orderRepository,
  }) : _stockRepository = stockRepository,
       _orderRepository = orderRepository,
       super(StockInitial()) {
    on<StockLoad>((event, emit) async {
      try {
        emit(const StockLoading(message: 'Загрузка информации о запасе'));

        final stockItems = await _stockRepository.getStockItems();
        final orders = await _orderRepository.getOrders();

        /// {merchId: остаток}
        final Map<String, int> remainders = {
          for (final item in stockItems) item.merchId: item.quantity,
        };

        for (final order in orders) {
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
    });
    on<StockAdd>((event, emit) async {
      try {
        emit(const StockLoading(message: 'Добавление в запас'));
        await _stockRepository.addStockItem(event.merchId);
        add(const StockLoad());
      } catch (e) {
        emit(StockError(error: e));
      }
    });
    on<StockEdit>((event, emit) async {
      try {
        emit(const StockLoading(message: 'Изменение запаса'));
        await _stockRepository.editStockItem(event.merchId, event.quantity);
        add(const StockLoad());
      } catch (e) {
        emit(StockError(error: e));
      }
    });
    on<StockDelete>((event, emit) async {
      try {
        emit(const StockLoading(message: 'Удаление из запаса'));
        await _stockRepository.deleteStockItem(event.merchId);
        add(const StockLoad());
      } catch (e) {
        emit(StockError(error: e));
      }
    });
    on<StockRecalculate>((event, emit) {
      add(const StockLoad());
    });
  }
}
