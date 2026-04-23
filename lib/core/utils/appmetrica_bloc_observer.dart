// translate-me-ignore-all-file

import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppmetricaBlocObserver extends BlocObserver {
  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    AppMetrica.reportError(
      message: "${bloc.runtimeType} Error",
      errorDescription: AppMetricaErrorDescription.fromObjectAndStackTrace(
        error,
        stackTrace,
      ),
    );
    super.onError(bloc, error, stackTrace);
  }
}
