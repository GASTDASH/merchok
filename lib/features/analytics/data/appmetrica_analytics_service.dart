import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:flutter/foundation.dart' show kReleaseMode, debugPrint;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:merchok/features/analytics/domain/analytics_event.dart';
import 'package:merchok/features/analytics/domain/analytics_service.dart';

/// Реализация сервиса аналитики через Yandex AppMetrica
class AppMetricaAnalyticsService implements AnalyticsService {
  bool _initialized = false;

  @override
  Future<void> initialize() async {
    if (_initialized || !kReleaseMode) return;

    try {
      AppMetrica.activate(
        AppMetricaConfig(
          dotenv.env['APPMETRICA_API_KEY'].toString(),
          dataSendingEnabled: false,
          crashReporting: true,
          flutterCrashReporting: true,
          logs: true,
        ),
      );
      _initialized = true;
    } catch (e) {
      debugPrint('AppMetrica initialization failed: $e');
    }
  }

  @override
  Future<void> sendEvent(AnalyticsEvent event) async {
    if (!_initialized || !kReleaseMode) return;

    try {
      AppMetrica.reportEvent(event.eventName);
    } catch (e) {
      debugPrint('AppMetrica sendEvent failed: $e');
    }
  }

  @override
  Future<void> sendEventWithName(
    String eventName, {
    Map<String, dynamic>? params,
  }) async {
    if (!_initialized || !kReleaseMode) return;

    try {
      AppMetrica.reportEvent(eventName);
    } catch (e) {
      debugPrint('AppMetrica sendEventWithName failed: $e');
    }
  }

  @override
  Future<void> reportError({
    required String message,
    Object? error,
    StackTrace? stackTrace,
  }) async {
    if (!_initialized || !kReleaseMode) return;

    try {
      final errorDescription = AppMetricaErrorDescription(
        stackTrace != null && stackTrace.toString().isNotEmpty
            ? stackTrace
            : StackTrace.current,
        message: error?.toString(),
        type: error?.runtimeType.toString(),
      );

      AppMetrica.reportError(
        message: message,
        errorDescription: errorDescription,
      );
    } catch (e) {
      debugPrint('AppMetrica reportError failed: $e');
    }
  }

  @override
  Future<void> flushEvents() async {
    if (!_initialized || !kReleaseMode) return;

    try {
      AppMetrica.sendEventsBuffer();
    } catch (e) {
      debugPrint('AppMetrica flushEvents failed: $e');
    }
  }

  @override
  Future<void> setEnabled(bool enabled) async {
    if (!_initialized) return;

    try {
      AppMetrica.setDataSendingEnabled(enabled);
    } catch (e) {
      debugPrint('AppMetrica setEnabled failed: $e');
    }
  }
}
