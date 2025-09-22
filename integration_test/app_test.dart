import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:integration_test/integration_test.dart';
import 'package:merchok/app/app.dart';
import 'package:merchok/core/core.dart';
import 'package:merchok/features/festival/festival.dart';
import 'package:merchok/features/merch/merch.dart';
import 'package:merchok/features/orders/orders.dart';
import 'package:merchok/features/payment_method/payment_method.dart';
import 'package:merchok/generated/l10n.dart';
import 'package:merchok/main.dart';
import 'package:mockito/mockito.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _MockPathProviderPlatform extends Mock
    with MockPlatformInterfaceMixin
    implements PathProviderPlatform {
  @override
  Future<String?> getApplicationDocumentsPath() async => '\\mock';
}

Future<void> _initTest() async {
  // PathProviderPlatform.instance = _MockPathProviderPlatform();
  SharedPreferences.setMockInitialValues({});
  final prefs = await SharedPreferences.getInstance();
  await prefs.clear();

  await Hive.initFlutter();

  Hive
    ..registerAdapter(MerchAdapter())
    ..registerAdapter(FestivalAdapter())
    ..registerAdapter(PaymentMethodAdapter())
    ..registerAdapter(OrderItemAdapter())
    ..registerAdapter(OrderAdapter());

  (await Hive.openBox<Merch>(HiveBoxesNames.merches)).clear();
  (await Hive.openBox<Festival>(HiveBoxesNames.festivals)).clear();
  (await Hive.openBox<PaymentMethod>(HiveBoxesNames.paymentMethods)).clear();
  (await Hive.openBox<Order>(HiveBoxesNames.orders)).clear();

  initTalker();
  await registerRepositories();
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Интеграционный тест.', () {
    const kTestFestivalName = 'Test festival';

    testWidgets('Запуск приложения', (tester) async {
      // Инициализация
      await _initTest();

      // Запуск приложения
      await tester.pumpWidget(const MerchokApp());
      await tester.pumpAndSettle();

      // Найти текст об отсутствии мера
      expect(find.text(S.current.noMerch), findsOneWidget);
    });
    testWidgets('Создание фестиваля', (tester) async {
      await tester.pumpWidget(const MerchokApp());
      await tester.pumpAndSettle();

      // Найти кнопку с иконкой календаря
      final festivalButton = find.byWidgetPredicate(
        (w) =>
            w is BaseSvgIcon &&
            w.bytesLoader == SvgAssetLoader(IconNames.calendar),
      );
      expect(festivalButton, findsOneWidget);
      // Нажать её
      await tester.tap(festivalButton);
      await tester.pumpAndSettle();

      // Найти кнопку с иконкой плюса
      final addButton = find.byWidgetPredicate(
        (w) =>
            w is BaseSvgIcon && w.bytesLoader == SvgAssetLoader(IconNames.add),
      );
      expect(addButton, findsOneWidget);
      // Нажать её
      await tester.tap(addButton);
      await tester.pumpAndSettle();

      // Найти текстовое поле
      final textField = find.byType(TextField);
      expect(textField, findsOneWidget);
      // Написать имя фестиваля
      await tester.enterText(textField, kTestFestivalName);
      await tester.pumpAndSettle();

      // Найти кнопку добавить
      final addFestButton = find.byType(BaseButton);
      expect(addFestButton, findsOneWidget);
      // Нажать её
      await tester.tap(addFestButton);
      await tester.pumpAndSettle();

      // Найти название добавленного фестиваля
      expect(find.text(kTestFestivalName), findsOneWidget);
    });
    testWidgets('Редактирование фестиваля', (tester) async {
      await tester.pumpWidget(const MerchokApp());
      await tester.pumpAndSettle();

      // Найти иконку карандаша
      final editButton = find.byWidgetPredicate(
        (w) =>
            w is BaseSvgIcon && w.bytesLoader == SvgAssetLoader(IconNames.edit),
      );
      expect(editButton, findsOneWidget);
      // Нажать её
      await tester.tap(editButton);
      await tester.pumpAndSettle();

      // Найти кнопку с датой начала фестиваля
      final startDateButton = find.byWidgetPredicate(
        (w) => w is Text && w.data == DateTime.now().toCompactString(),
      );
      expect(startDateButton, findsWidgets);
      // Нажать её
      await tester.tap(startDateButton.first);
      await tester.pumpAndSettle();

      // Найти кнопку на день позже
      final dayBeforeText = find.text(
        DateTime.now().subtract(Duration(days: 1)).day.toString(),
      );
      expect(dayBeforeText, findsOneWidget);
      // Нажать на неё
      await tester.tap(dayBeforeText);
      await tester.pumpAndSettle();
    });
    testWidgets('Выбор текущего фестиваля', (tester) async {
      await tester.pumpWidget(const MerchokApp());
      await tester.pumpAndSettle();

      // Найти название фестиваля
      final festivalName = find.text(kTestFestivalName);
      expect(festivalName, findsOneWidget);
      // Нажать на него
      await tester.tap(festivalName);
      await tester.pumpAndSettle();

      // Найти галочку
      expect(find.byIcon(Icons.done), findsOneWidget);

      // Найти кнопку назад
      final backButton = find.backButton();
      expect(backButton, findsOneWidget);
      // Нажать на неё
      await tester.tap(backButton);
      await tester.pumpAndSettle();

      // Найти название фестиваля
      expect(find.text(kTestFestivalName), findsOneWidget);
    });
    testWidgets('Создание мерча', (tester) async {
      await tester.pumpWidget(const MerchokApp());
      await tester.pumpAndSettle();

      // Найти кнопку с текстом "Добавить"
      final addButton = find.text(S.current.add);
      expect(addButton, findsOneWidget);
      // Нажать её
      await tester.tap(addButton);
      await tester.pumpAndSettle();

      // Найти название созданного мерча
      expect(find.text(S.current.untitled), findsOneWidget);
    });
  });
}
