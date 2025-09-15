import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merchok/features/payment_method/payment_method.dart';
import 'package:merchok/generated/l10n.dart';

part 'payment_method_event.dart';
part 'payment_method_state.dart';

class PaymentMethodBloc extends Bloc<PaymentMethodEvent, PaymentMethodState> {
  final PaymentMethodRepository _paymentMethodRepository;

  PaymentMethodBloc({required PaymentMethodRepository paymentMethodRepository})
    : _paymentMethodRepository = paymentMethodRepository,
      super(PaymentMethodInitial()) {
    on<PaymentMethodLoad>((event, emit) async {
      try {
        emit(PaymentMethodLoading(message: S.current.paymentMethodLoading));
        loadPaymentMethods(emit);
      } catch (e) {
        emit(PaymentMethodError(error: e));
      }
    });
    on<PaymentMethodAdd>((event, emit) async {
      try {
        emit(PaymentMethodLoading(message: S.current.paymentMethodCreating));
        await _paymentMethodRepository.editPaymentMethod(event.paymentMethod);
        add(PaymentMethodLoad());
      } catch (e) {
        emit(PaymentMethodError(error: e));
      }
    });
    on<PaymentMethodEdit>((event, emit) async {
      try {
        emit(PaymentMethodLoading(message: S.current.paymentMethodChanging));
        await _paymentMethodRepository.editPaymentMethod(event.paymentMethod);
        add(PaymentMethodLoad());
      } catch (e) {
        emit(PaymentMethodError(error: e));
      }
    });
    on<PaymentMethodDelete>((event, emit) async {
      try {
        emit(PaymentMethodLoading(message: S.current.paymentMethodDeleting));
        await _paymentMethodRepository.deletePaymentMethod(
          event.paymentMethodId,
        );
        add(PaymentMethodLoad());
      } catch (e) {
        emit(PaymentMethodError(error: e));
      }
    });
  }

  /// Получение списка фестивалей и вызов состояния [FestivalLoaded]
  Future<void> loadPaymentMethods(Emitter<PaymentMethodState> emit) async {
    final paymentMethodList = await _paymentMethodRepository
        .getPaymentMethods();
    emit(PaymentMethodLoaded(paymentMethodList: paymentMethodList));
  }
}
