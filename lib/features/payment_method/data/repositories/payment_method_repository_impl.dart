import 'package:merchok/features/payment_method/payment_method.dart';

class PaymentMethodRepositoryImpl implements PaymentMethodRepository {
  final Map<String, PaymentMethod> paymentMethodList = {};

  @override
  Future<List<PaymentMethod>> getPaymentMethods() async =>
      paymentMethodList.values.toList();

  @override
  Future<void> editPaymentMethod(PaymentMethod paymentMethod) async =>
      paymentMethodList.addAll({paymentMethod.id: paymentMethod});

  @override
  Future<void> deletePaymentMethod(String paymentMethodId) async =>
      paymentMethodList.remove(paymentMethodId);
}
