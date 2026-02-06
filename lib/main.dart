import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
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
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talker_bloc_logger/talker_bloc_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  ErrorWidget.builder = (FlutterErrorDetails details) =>
      CustomErrorWidget(details);

  try {
    await _initHive();
    _initTalker();
    await _registerRepositories();

    runApp(const MerchokApp());
  } catch (e, st) {
    runApp(ErrorApp(exception: e, stack: st));
  }
}

Future<void> _initHive() async {
  await Hive.initFlutter();

  Hive
    ..registerAdapter(MerchAdapter())
    ..registerAdapter(FestivalAdapter())
    ..registerAdapter(PaymentMethodAdapter())
    ..registerAdapter(OrderItemAdapter())
    ..registerAdapter(OrderAdapter())
    ..registerAdapter(CategoryAdapter());

  await Hive.openBox<Merch>(HiveBoxesNames.merches);
  await Hive.openBox<Festival>(HiveBoxesNames.festivals);
  await Hive.openBox<PaymentMethod>(HiveBoxesNames.paymentMethods);
  await Hive.openBox<Order>(HiveBoxesNames.orders);
  await Hive.openBox<Category>(HiveBoxesNames.categories);
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

Future<void> _initTalker() async {
  final talker = TalkerFlutter.init();
  GetIt.I.registerSingleton<Talker>(talker);

  Bloc.observer = TalkerBlocObserver(
    talker: talker,
    settings: const TalkerBlocLoggerSettings(
      printTransitions: false,
      printChanges: true,
      printStateFullData: false,
    ),
  );
}
