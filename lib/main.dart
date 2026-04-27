// translate-me-ignore-all-file
import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:flutter/foundation.dart' show kReleaseMode;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'package:merchok/app/app.dart';
import 'package:merchok/core/core.dart';
import 'package:merchok/features/cart/cart.dart';
import 'package:merchok/features/category/category.dart';
import 'package:merchok/features/festival/festival.dart';
import 'package:merchok/features/merch/merch.dart';
import 'package:merchok/features/orders/orders.dart';
import 'package:merchok/features/payment_method/payment_method.dart';
import 'package:merchok/features/settings/settings.dart';
import 'package:merchok/features/stock/stock.dart';
import 'package:merchok/hive_registrar.g.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talker_bloc_logger/talker_bloc_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Настройка обработки фатальных Flutter-ошибок
  FlutterError.onError = (details) async {
    if (kReleaseMode) {
      final stack = details.stack;

      AppMetrica.reportError(
        message: "Flutter.onError",
        errorDescription: AppMetricaErrorDescription(
          stack != null && stack.toString().isNotEmpty
              ? stack
              : StackTrace.current,
          message: details.exceptionAsString(),
          type: details.exception.runtimeType.toString(),
        ),
      );
      AppMetrica.sendEventsBuffer();
    }
  };

  // Кастомный виджет для отображения ошибок
  ErrorWidget.builder = (FlutterErrorDetails details) =>
      CustomErrorWidget(details);

  try {
    // Загрузка переменных окружения из .env
    await loadDotEnv();

    // Инициализация аналитики AppMetrica с отчётами о сбоях
    if (kReleaseMode) {
      AppMetrica.activate(
        AppMetricaConfig(
          dotenv.env['APPMETRICA_API_KEY'].toString(),
          crashReporting: true,
          flutterCrashReporting: true,
          logs: true,
        ),
      );
    }

    // Настройка системы логирования Talker
    final talker = _initTalker();

    // Настройка глобального наблюдателя для всех BLoC-инстансов
    // - AppmetricaBlocObserver: отправка метрик и аналитики переходов BLoC
    // - TalkerBlocObserver: логирование изменений состояний с настройками:
    Bloc.observer = MultiBlocObserver(
      observers: [
        AppmetricaBlocObserver(),
        TalkerBlocObserver(
          talker: talker,
          settings: const TalkerBlocLoggerSettings(
            printTransitions: false,
            printChanges: true,
            printStateFullData: false,
          ),
        ),
      ],
    );

    // Инициализация хранилища Hive и регистрация репозиториев
    await _initHive();
    await _registerRepositories();

    // Запуск основного приложения
    runApp(const MerchokApp());
  } catch (e, st) {
    // Обработка ошибок инициализации: отчёт и запуск экрана ошибки
    final details = FlutterErrorDetails(exception: e, stack: st);
    FlutterError.reportError(details);
    runApp(ErrorApp(details));
  }
}

Future<void> _initHive() async {
  await Hive.initFlutter();
  Hive.registerAdapters();

  await Hive.openBox<Merch>(HiveBoxesNames.merches);
  await Hive.openBox<Festival>(HiveBoxesNames.festivals);
  await Hive.openBox<PaymentMethod>(HiveBoxesNames.paymentMethods);
  await Hive.openBox<Order>(HiveBoxesNames.orders);
  await Hive.openBox<Category>(HiveBoxesNames.categories);
  await Hive.openBox<Map>(HiveBoxesNames.stock);
}

Future<void> _registerRepositories() async {
  final prefs = await SharedPreferences.getInstance();

  GetIt.I
    ..registerSingleton<SettingsRepository>(
      SettingsRepositoryImpl(prefs: prefs),
    )
    ..registerSingleton<MerchRepository>(MerchRepositoryImpl())
    ..registerSingleton<CartRepository>(CartRepositoryImpl())
    ..registerSingleton<FestivalRepository>(FestivalRepositoryImpl())
    ..registerSingleton<PaymentMethodRepository>(PaymentMethodRepositoryImpl())
    ..registerSingleton<OrderRepository>(OrderRepositoryImpl())
    ..registerSingleton<CategoryRepository>(CategoryRepositoryImpl())
    ..registerSingleton<StockRepository>(StockRepositoryImpl());
}

Talker _initTalker() {
  final talker = TalkerFlutter.init();
  GetIt.I.registerSingleton<Talker>(talker);
  return talker;
}

Future<void> loadDotEnv() async {
  try {
    await dotenv.load(fileName: ".env"); // Load environment variables
  } catch (e) {
    throw Exception('Error loading .env file: $e'); // Print error if any
  }
}
