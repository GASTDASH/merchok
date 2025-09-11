part of 'festival_bloc.dart';

sealed class FestivalState extends Equatable {
  const FestivalState();

  @override
  List<Object?> get props => [];
}

final class FestivalInitial extends FestivalState {}

final class FestivalLoaded extends FestivalState {
  const FestivalLoaded({required this.festivalList, this.selectedFestival});

  final List<Festival> festivalList;
  final Festival? selectedFestival;

  @override
  List<Object?> get props =>
      super.props..addAll([festivalList, selectedFestival]);
}

final class FestivalLoading extends FestivalState {
  const FestivalLoading({required this.message});

  final String? message;

  @override
  List<Object?> get props => super.props..addAll([message]);
}

final class FestivalError extends FestivalState {
  const FestivalError({required this.error});

  final Object error;

  @override
  List<Object?> get props => super.props..addAll([error]);
}
