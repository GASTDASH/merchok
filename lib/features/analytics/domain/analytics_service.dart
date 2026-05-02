import 'analytics_event.dart';

/// Интерфейс сервиса аналитики
/// Абстракция для работы с различными сервисами аналитики (AppMetrica, Firebase, и т.д.)
abstract class AnalyticsService {
  /// Инициализация сервиса аналитики
  Future<void> initialize();

  /// Отправить событие аналитики
  Future<void> sendEvent(AnalyticsEvent event);

  /// Отправить событие с именем и параметрами
  Future<void> sendEventWithName(
    String eventName, {
    Map<String, dynamic>? params,
  });

  /// Сообщить об ошибке
  ///
  /// [message] - краткое описание ошибки
  /// [error] - объект ошибки (исключение)
  /// [stackTrace] - стектрейс ошибки
  Future<void> reportError({
    required String message,
    Object? error,
    StackTrace? stackTrace,
  });

  /// Буферизировать события для отправки (если сервис поддерживает)
  Future<void> flushEvents();

  /// Включить/выключить аналитику
  Future<void> setEnabled(bool enabled);
}
