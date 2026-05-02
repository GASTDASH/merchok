part of 'analytics_cubit.dart';

/// Состояние Cubit для управления аналитикой
class AnalyticsState extends Equatable {
  const AnalyticsState({required this.enabled});

  factory AnalyticsState.initial() => const AnalyticsState(enabled: true);

  final bool enabled;

  @override
  List<Object?> get props => [enabled];

  @override
  String toString() => 'AnalyticsCubitState(enabled: $enabled)';

  AnalyticsState copyWith({bool? enabled}) {
    return AnalyticsState(enabled: enabled ?? this.enabled);
  }
}
