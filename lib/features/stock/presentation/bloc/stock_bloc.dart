import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merchok/features/stock/stock.dart';

part 'stock_event.dart';
part 'stock_state.dart';

class StockBloc extends Bloc<StockEvent, StockState> {
  final StockRepository _stockRepository;

  StockBloc({required StockRepository stockRepository})
    : _stockRepository = stockRepository,
      super(StockInitial()) {
    on<StockLoad>((event, emit) async {
      try {
        emit(const StockLoading(message: 'Загрузка информации о запасе'));
        final stockItems = await _stockRepository.getStockItems();
        emit(StockLoaded(stockItems: stockItems));
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
  }
}
