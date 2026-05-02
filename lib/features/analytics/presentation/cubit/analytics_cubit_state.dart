part of 'analytics_cubit.dart';

/// Состояние Cubit для управления аналитикой
class AnalyticsCubitState extends Equatable {
  const AnalyticsCubitState({required this.enabled});

  factory AnalyticsCubitState.initial() =>
      const AnalyticsCubitState(enabled: true);

  final bool enabled;

  @override
  List<Object?> get props => [enabled];

  @override
  String toString() => 'AnalyticsCubitState(enabled: $enabled)';

  AnalyticsCubitState copyWith({bool? enabled}) {
    return AnalyticsCubitState(enabled: enabled ?? this.enabled);
  }
}
