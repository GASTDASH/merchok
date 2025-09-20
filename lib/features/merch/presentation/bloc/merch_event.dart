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

  @override
  List<Object> get props => super.props..addAll([merch]);
}

final class MerchDelete extends MerchEvent {
  const MerchDelete({required this.merchId});

  final String merchId;

  @override
  List<Object> get props => super.props..addAll([merchId]);
}

final class MerchImport extends MerchEvent {
  const MerchImport({required this.merchList});

  final List<Merch> merchList;

  @override
  List<Object> get props => super.props..addAll([merchList]);
}
