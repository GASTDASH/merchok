part of 'stock_bloc.dart';

sealed class StockState extends Equatable {
  const StockState();

  @override
  List<Object?> get props => [];
}

final class StockInitial extends StockState {}

final class StockLoaded extends StockState {
  const StockLoaded({required this.stockItems});

  final List<StockItem> stockItems;

  @override
  List<Object?> get props => super.props..addAll([stockItems]);
}

final class StockLoading extends StockState {
  const StockLoading({this.message});

  final String? message;

  @override
  List<Object?> get props => super.props..addAll([message]);
}

final class StockError extends StockState {
  const StockError({this.error});

  final Object? error;

  @override
  List<Object?> get props => super.props..addAll([error]);
}
