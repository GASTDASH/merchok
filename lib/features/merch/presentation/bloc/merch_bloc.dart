import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merchok/features/merch/merch.dart';
import 'package:uuid/uuid.dart';

part 'merch_event.dart';
part 'merch_state.dart';

class MerchBloc extends Bloc<MerchEvent, MerchState> {
  final MerchRepository _merchRepository;

  MerchBloc({required MerchRepository merchRepository})
    : _merchRepository = merchRepository,
      super(MerchInitial()) {
    on<MerchLoad>((event, emit) async {
      try {
        emit(MerchLoading(message: 'Получение списка мерчей'));
        final List<Merch> merchList = await _merchRepository.getMerches();
        emit(MerchLoaded(merchList: merchList));
      } catch (e) {
        emit(MerchError(error: e));
      }
    });
    on<MerchAdd>((event, emit) async {
      try {
        emit(MerchLoading(message: 'Создание нового мерча'));
        await _merchRepository.saveMerch(
          Merch(id: Uuid().v4(), name: 'Без названия', price: 0),
        );
        add(MerchLoad());
      } catch (e) {
        emit(MerchError(error: e));
      }
    });
    on<MerchEdit>((event, emit) async {
      try {
        emit(MerchLoading(message: 'Изменение информации о мерче'));
        await _merchRepository.saveMerch(event.merch);
        add(MerchLoad());
      } catch (e) {
        emit(MerchError(error: e));
      }
    });
    on<MerchDelete>((event, emit) async {
      try {
        emit(MerchLoading(message: 'Удаление мерча'));
        await _merchRepository.deleteMerch(event.merchId);
        add(MerchLoad());
      } catch (e) {
        emit(MerchError(error: e));
      }
    });
  }
}
