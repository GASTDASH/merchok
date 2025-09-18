import 'package:hive/hive.dart';
import 'package:merchok/core/core.dart';
import 'package:merchok/features/payment_method/payment_method.dart';

class PaymentMethodRepositoryImpl implements PaymentMethodRepository {
  final Box<PaymentMethod> paymentMethodBox = Hive.box(
    HiveBoxesNames.paymentMethods,
  );

  @override
  Future<List<PaymentMethod>> getPaymentMethods() async =>
      paymentMethodBox.values.toList();

  @override
  Future<void> editPaymentMethod(PaymentMethod paymentMethod) async =>
      await paymentMethodBox.put(paymentMethod.id, paymentMethod);

  @override
  Future<void> deletePaymentMethod(String paymentMethodId) async =>
      await paymentMethodBox.delete(paymentMethodId);
}
