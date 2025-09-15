import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merchok/features/payment_method/payment_method.dart';

class CurrentPaymentMethodCubit extends Cubit<PaymentMethod?> {
  CurrentPaymentMethodCubit() : super(null);

  Future<void> selectPaymentMethod(PaymentMethod? paymentMethod) async =>
      emit(paymentMethod);
}
