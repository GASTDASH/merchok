import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merchok/features/analytics/analytics.dart';
import 'package:merchok/features/settings/settings.dart';

part 'analytics_cubit_state.dart';

/// Cubit для управления состоянием аналитики в UI
class AnalyticsCubit extends Cubit<AnalyticsState> {
  AnalyticsCubit({
    required AnalyticsRepository analyticsRepository,
    required SettingsRepository settingsRepository,
  }) : _analyticsRepository = analyticsRepository,
       _settingsRepository = settingsRepository,
       super(AnalyticsState.initial());

  final AnalyticsRepository _analyticsRepository;
  final SettingsRepository _settingsRepository;

  /// Включить аналитику
  Future<void> enable() async {
    await _analyticsRepository.setEnabled(true);
    await _settingsRepository.setAnalyticsEnabled(true);
    emit(const AnalyticsState(enabled: true));
  }

  /// Выключить аналитику
  Future<void> disable() async {
    await _analyticsRepository.setEnabled(false);
    await _settingsRepository.setAnalyticsEnabled(false);
    emit(const AnalyticsState(enabled: false));
  }
}
