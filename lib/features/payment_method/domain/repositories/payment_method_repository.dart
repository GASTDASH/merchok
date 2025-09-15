import 'package:merchok/features/payment_method/payment_method.dart';

abstract interface class PaymentMethodRepository {
  Future<List<PaymentMethod>> getPaymentMethods();
  Future<void> editPaymentMethod(PaymentMethod paymentMethod);
  Future<void> deletePaymentMethod(String paymentMethodId);
}
