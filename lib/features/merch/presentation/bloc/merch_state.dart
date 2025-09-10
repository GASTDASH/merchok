part of 'merch_bloc.dart';

sealed class MerchState extends Equatable {
  const MerchState();

  @override
  List<Object> get props => [];
}

final class MerchInitial extends MerchState {}

final class MerchLoaded extends MerchState {
  const MerchLoaded({required this.merchList});

  final List<Merch> merchList;
}

final class MerchLoading extends MerchState {
  const MerchLoading({this.message});

  final String? message;
}

final class MerchError extends MerchState {
  const MerchError({this.error});

  final Object? error;
}
