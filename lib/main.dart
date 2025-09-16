import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:merchok/app/app.dart';
import 'package:merchok/features/cart/cart.dart';
import 'package:merchok/features/festival/festival.dart';
import 'package:merchok/features/merch/merch.dart';
import 'package:merchok/features/orders/orders.dart';
import 'package:merchok/features/payment_method/payment_method.dart';
import 'package:merchok/features/settings/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talker_bloc_logger/talker_bloc_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  _talkerInit();
  await _registerRepositories();

  runApp(const MerchokApp());
}

Future<void> _registerRepositories() async {
  final prefs = await SharedPreferences.getInstance();

  final settingsRepository = SettingsRepositoryImpl(prefs: prefs);
  GetIt.I.registerSingleton<SettingsRepository>(settingsRepository);

  final merchRepository = MerchRepositoryImpl();
  GetIt.I.registerSingleton<MerchRepository>(merchRepository);

  final cartRepository = CartRepositoryImpl();
  GetIt.I.registerSingleton<CartRepository>(cartRepository);

  final festivalRepository = FestivalRepositoryImpl();
  GetIt.I.registerSingleton<FestivalRepository>(festivalRepository);

  final paymentMethodRepository = PaymentMethodRepositoryImpl();
  GetIt.I.registerSingleton<PaymentMethodRepository>(paymentMethodRepository);

  final orderRepository = OrderRepositoryImpl();
  GetIt.I.registerSingleton<OrderRepository>(orderRepository);
}

void _talkerInit() {
  final talker = TalkerFlutter.init();
  GetIt.I.registerSingleton<Talker>(talker);

  Bloc.observer = TalkerBlocObserver(
    talker: talker,
    settings: TalkerBlocLoggerSettings(
      printTransitions: false,
      printChanges: true,
    ),
  );
}
