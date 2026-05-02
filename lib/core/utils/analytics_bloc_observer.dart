import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:merchok/features/analytics/analytics.dart';

/// Наблюдатель за BLoC-ами для отправки событий в аналитику
class AnalyticsBlocObserver extends BlocObserver {
  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    final analytics = GetIt.I<AnalyticsRepository>();
    analytics.reportError(
      message: "${bloc.runtimeType} Error",
      error: error,
      stackTrace: stackTrace,
    );
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);

    // Отправляем событие смены состояния в аналитику
    final analytics = GetIt.I<AnalyticsRepository>();
    analytics.sendEventWithName(
      'bloc_change_${bloc.runtimeType}',
      params: {
        'bloc': bloc.runtimeType.toString(),
        'change': change.toString(),
      },
    );
  }
}
