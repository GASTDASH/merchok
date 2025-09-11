part of 'festival_bloc.dart';

sealed class FestivalEvent extends Equatable {
  const FestivalEvent();

  @override
  List<Object> get props => [];
}

final class FestivalLoad extends FestivalEvent {}

final class FestivalAdd extends FestivalEvent {
  const FestivalAdd({required this.festivalName});

  final String festivalName;

  @override
  List<Object> get props => super.props..addAll([festivalName]);
}

final class FestivalEdit extends FestivalEvent {
  const FestivalEdit({required this.festival});

  final Festival festival;

  @override
  List<Object> get props => super.props..addAll([festival]);
}

final class FestivalDelete extends FestivalEvent {
  const FestivalDelete({required this.festivalId});

  final String festivalId;

  @override
  List<Object> get props => super.props..addAll([festivalId]);
}
