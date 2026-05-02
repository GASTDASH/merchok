import 'package:merchok/features/analytics/analytics.dart';

/// Репозиторий аналитики - единая точка доступа для работы с аналитикой в приложении
class AnalyticsRepository {
  AnalyticsRepository(this._analyticsService);

  final AnalyticsService _analyticsService;

  /// Инициализация сервиса аналитики
  Future<void> initialize() => _analyticsService.initialize();

  /// Отправить событие аналитики
  Future<void> sendEvent(AnalyticsEvent event) =>
      _analyticsService.sendEvent(event);

  /// Отправить событие с именем и параметрами
  Future<void> sendEventWithName(
    String eventName, {
    Map<String, dynamic>? params,
  }) => _analyticsService.sendEventWithName(eventName, params: params);

  /// Сообщить об ошибке
  ///
  /// [message] - краткое описание ошибки
  /// [error] - объект ошибки (исключение)
  /// [stackTrace] - стектрейс ошибки
  Future<void> reportError({
    required String message,
    Object? error,
    StackTrace? stackTrace,
  }) => _analyticsService.reportError(
    message: message,
    error: error,
    stackTrace: stackTrace,
  );

  /// Буферизировать события для отправки
  Future<void> flushEvents() => _analyticsService.flushEvents();

  /// Включить/выключить аналитику
  Future<void> setEnabled(bool enabled) =>
      _analyticsService.setEnabled(enabled);
}
