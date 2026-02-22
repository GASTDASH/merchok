part of 'stat_bloc.dart';

sealed class StatState extends Equatable {
  const StatState();

  @override
  List<Object?> get props => [];
}

final class StatInitial extends StatState {}

final class StatLoading extends StatState {
  const StatLoading({this.message});

  final String? message;

  @override
  List<Object?> get props => super.props..addAll([message]);
}

final class StatLoaded extends StatState {
  const StatLoaded({
    required this.orderList,
    required this.allStockItems,
    required this.merchList,
  });

  final List<Order> orderList;
  final List<StockItem> allStockItems;
  final List<Merch> merchList;

  @override
  List<Object?> get props =>
      super.props..addAll([orderList, allStockItems, merchList]);
}

final class StatError extends StatState {
  const StatError({this.error});

  final Object? error;

  @override
  List<Object?> get props => super.props..addAll([error]);
}
