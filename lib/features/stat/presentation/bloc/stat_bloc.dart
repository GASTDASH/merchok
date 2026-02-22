import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merchok/features/merch/merch.dart';
import 'package:merchok/features/orders/orders.dart';
import 'package:merchok/features/stock/stock.dart';
import 'package:merchok/generated/l10n.dart';

part 'stat_event.dart';
part 'stat_state.dart';

class StatBloc extends Bloc<StatEvent, StatState> {
  StatBloc({
    required OrderRepository orderRepository,
    required StockRepository stockRepository,
    required MerchRepository merchRepository,
  }) : _orderRepository = orderRepository,
       _stockRepository = stockRepository,
       _merchRepository = merchRepository,
       super(StatInitial()) {
    on<StatLoad>(_onStatLoad);
  }

  final OrderRepository _orderRepository;
  final StockRepository _stockRepository;
  final MerchRepository _merchRepository;

  Future<void> _onStatLoad(StatLoad event, Emitter<StatState> emit) async {
    try {
      emit(StatLoading(message: S.current.loading));

      final results = await Future.wait([
        _orderRepository.getOrders(),
        _stockRepository.getAllStockItems(),
        _merchRepository.getMerches(),
      ]);

      final orderList = results[0] as List<Order>;
      final allStockItems = results[1] as List<StockItem>;
      final merchList = results[2] as List<Merch>;

      emit(
        StatLoaded(
          orderList: orderList,
          allStockItems: allStockItems,
          merchList: merchList,
        ),
      );
    } catch (e) {
      emit(StatError(error: e));
    }
  }
}
