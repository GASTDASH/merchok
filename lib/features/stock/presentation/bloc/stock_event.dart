part of 'stock_bloc.dart';

sealed class StockEvent extends Equatable {
  const StockEvent();

  @override
  List<Object> get props => [];
}

final class StockLoad extends StockEvent {
  const StockLoad();
}

final class StockAdd extends StockEvent {
  const StockAdd({required this.merchId});

  final String merchId;

  @override
  List<Object> get props => super.props..addAll([merchId]);
}

final class StockEdit extends StockEvent {
  const StockEdit({required this.merchId, required this.quantity});

  final String merchId;
  final int quantity;

  @override
  List<Object> get props => super.props..addAll([merchId, quantity]);
}

final class StockDelete extends StockEvent {
  const StockDelete({required this.merchId});

  final String merchId;

  @override
  List<Object> get props => super.props..addAll([merchId]);
}
