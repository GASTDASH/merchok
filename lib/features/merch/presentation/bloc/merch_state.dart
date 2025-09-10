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

  @override
  List<Object> get props => super.props..addAll([merchList]);
}

final class MerchLoading extends MerchState {
  const MerchLoading({this.message});

  final String? message;

  @override
  List<Object> get props => super.props..addAll([message ?? '']);
}

final class MerchError extends MerchState {
  const MerchError({required this.error});

  final Object error;

  @override
  List<Object> get props => super.props..addAll([error]);
}
