part of 'stat_bloc.dart';

sealed class StatEvent extends Equatable {
  const StatEvent();

  @override
  List<Object?> get props => [];
}

final class StatLoad extends StatEvent {
  const StatLoad();
}
