part of 'merch_bloc.dart';

sealed class MerchEvent extends Equatable {
  const MerchEvent();

  @override
  List<Object> get props => [];
}

final class MerchLoad extends MerchEvent {}

final class MerchAdd extends MerchEvent {}

final class MerchEdit extends MerchEvent {
  const MerchEdit({required this.merch});

  final Merch merch;
}

final class MerchDelete extends MerchEvent {
  const MerchDelete({required this.merchId});

  final String merchId;
}
