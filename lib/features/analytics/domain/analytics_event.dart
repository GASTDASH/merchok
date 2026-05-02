import 'package:equatable/equatable.dart';

/// Базовый класс для событий аналитики
abstract class AnalyticsEvent extends Equatable {
  const AnalyticsEvent();

  /// Имя события для отправки в аналитику
  String get eventName;

  /// Параметры события
  Map<String, dynamic> get params => const {};

  @override
  List<Object?> get props => [eventName];
}

/// Событие открытия экрана
class ScreenViewEvent extends AnalyticsEvent {
  final String screenName;

  const ScreenViewEvent(this.screenName);

  @override
  String get eventName => screenName;

  @override
  Map<String, dynamic> get params => {'screen': screenName};

  @override
  List<Object?> get props => [screenName];
}

/// Событие нажатия на кнопку
class ButtonClickEvent extends AnalyticsEvent {
  final String buttonName;
  final Map<String, dynamic>? additionalParams;

  const ButtonClickEvent(this.buttonName, {this.additionalParams});

  @override
  String get eventName => 'button_click_$buttonName';

  @override
  Map<String, dynamic> get params => {
    'button': buttonName,
    if (additionalParams != null) ...additionalParams!,
  };

  @override
  List<Object?> get props => [buttonName, additionalParams];
}

/// Событие покупки
class PurchaseEvent extends AnalyticsEvent {
  final String merchId;
  final int quantity;
  final double price;
  final String? festivalId;

  const PurchaseEvent({
    required this.merchId,
    required this.quantity,
    required this.price,
    this.festivalId,
  });

  @override
  String get eventName => 'purchase';

  @override
  Map<String, dynamic> get params => {
    'merch_id': merchId,
    'quantity': quantity,
    'price': price,
    if (festivalId != null) 'festival_id': festivalId,
  };

  @override
  List<Object?> get props => [merchId, quantity, price, festivalId];
}
