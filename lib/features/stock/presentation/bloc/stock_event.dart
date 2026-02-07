part of 'stock_bloc.dart';

sealed class StockEvent extends Equatable {
  const StockEvent();

  @override
  List<Object?> get props => [];
}

final class StockLoad extends StockEvent {
  const StockLoad({this.festivalId});

  final String? festivalId;

  @override
  List<Object?> get props => super.props..addAll([festivalId]);
}

final class StockAdd extends StockEvent {
  const StockAdd({required this.merchId, required this.festivalId});

  final String festivalId;
  final String merchId;

  @override
  List<Object?> get props => super.props..addAll([merchId, festivalId]);
}

final class StockEdit extends StockEvent {
  const StockEdit({
    required this.merchId,
    required this.quantity,
    required this.festivalId,
  });

  final String festivalId;
  final String merchId;
  final int quantity;

  @override
  List<Object?> get props =>
      super.props..addAll([merchId, quantity, festivalId]);
}

final class StockDelete extends StockEvent {
  const StockDelete({required this.merchId, required this.festivalId});

  final String festivalId;
  final String merchId;

  @override
  List<Object?> get props => super.props..addAll([merchId, festivalId]);
}

final class StockRecalculate extends StockEvent {
  const StockRecalculate({required this.festivalId});

  final String festivalId;

  @override
  List<Object?> get props => super.props..addAll([festivalId]);
}
