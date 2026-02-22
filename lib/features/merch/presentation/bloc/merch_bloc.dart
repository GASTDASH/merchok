import 'dart:developer';
import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merchok/core/core.dart';
import 'package:merchok/features/merch/merch.dart';
import 'package:merchok/generated/l10n.dart';
import 'package:rxdart/rxdart.dart';
import 'package:uuid/uuid.dart';

part 'merch_event.dart';
part 'merch_state.dart';

/// EventTransformer с дебаунсом для локальных операций
EventTransformer<T> _debounceTransformer<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).switchMap(mapper);
}

class MerchBloc extends Bloc<MerchEvent, MerchState> {
  final MerchRepository _merchRepository;

  MerchBloc({required MerchRepository merchRepository})
    : _merchRepository = merchRepository,
      super(MerchInitial()) {
    // MerchLoad обрабатывается сразу без дебаунса
    on<MerchLoad>((event, emit) async {
      try {
        emit(MerchLoading(message: S.current.merchLoading));
        log('${DateTime.now()} - getting merchList');
        final List<Merch> merchList = await _merchRepository.getMerches();
        log('${DateTime.now()} - got merchList');
        emit(MerchLoaded(merchList: merchList));
      } catch (e) {
        emit(MerchError(error: e));
      }
    });
    // Локальные операции с дебаунсом 100ms — чтобы избежать избыточных перерисовок
    // при быстром последовательном выполнении действий
    on<MerchAdd>((event, emit) async {
      try {
        if (state is! MerchLoaded) return;
        final loadedState = state as MerchLoaded;

        emit(MerchLoading(message: S.current.merchCreating));

        final newMerch = Merch(
          id: const Uuid().v4(),
          name: S.current.untitled,
          price: 0,
        );
        await _merchRepository.editMerch(newMerch);

        emit(MerchLoaded(merchList: [...loadedState.merchList, newMerch]));
      } catch (e) {
        emit(MerchError(error: e));
      }
    }, transformer: _debounceTransformer(const Duration(milliseconds: 100)));
    on<MerchEdit>((event, emit) async {
      try {
        if (state is! MerchLoaded) return;
        final loadedState = state as MerchLoaded;

        emit(MerchLoading(message: S.current.merchChangeInfo));

        await _merchRepository.editMerch(event.merch);

        final newMerchList = [
          ...loadedState.merchList.map((m) {
            if (m.id == event.merch.id)
              return event.merch; // Заменяем изменённый мерч
            return m; // Возвращаем остальные
          }),
        ];
        emit(MerchLoaded(merchList: newMerchList));
      } catch (e) {
        emit(MerchError(error: e));
      }
    }, transformer: _debounceTransformer(const Duration(milliseconds: 100)));
    on<MerchDelete>((event, emit) async {
      try {
        if (state is! MerchLoaded) return;
        final loadedState = state as MerchLoaded;

        emit(MerchLoading(message: S.current.merchDeleting));

        await _merchRepository.deleteMerch(event.merchId);

        final newMerchList = [
          ...loadedState.merchList.where((m) => m.id != event.merchId),
        ];
        emit(MerchLoaded(merchList: newMerchList));
      } catch (e) {
        emit(MerchError(error: e));
      }
    }, transformer: _debounceTransformer(const Duration(milliseconds: 100)));
    on<MerchImport>((event, emit) async {
      try {
        if (state is! MerchLoaded) return;
        final loadedState = state as MerchLoaded;

        emit(MerchLoading(message: S.current.merchImporting));

        // Сохраняем все импортированные товары в репозиторий
        for (var merch in event.merchList) {
          await _merchRepository.editMerch(merch);
        }

        // Формируем новый список мерча
        final newMerchList = [
          // Проходит по старому списку и добавляет новый мерч если id совпал
          ...loadedState.merchList.map((m) {
            final importedMerch = event.merchList.firstWhere(
              (im) => im.id == m.id,
              orElse: () => m,
            );
            return importedMerch;
          }),
          // Добавляем новые товары, которых ещё нет в списке
          ...event.merchList.where(
            (im) => !loadedState.merchList.any((m) => m.id == im.id),
          ),
        ];
        emit(MerchLoaded(merchList: newMerchList));
      } catch (e) {
        emit(MerchError(error: e));
      }
    }, transformer: _debounceTransformer(const Duration(milliseconds: 100)));
    on<MerchUpdateImage>((event, emit) async {
      try {
        if (state is! MerchLoaded) return;
        final loadedState = state as MerchLoaded;

        emit(MerchLoading(message: S.current.merchUpdatingImage));

        final compressedImage = await ImageUtils.compressImage(event.image);
        final thumbnailImage = await ImageUtils.createThumbnail(event.image);

        final newMerch = event.merch.copyWith(
          image: compressedImage,
          thumbnail: thumbnailImage,
        );
        await _merchRepository.editMerch(newMerch);

        final newMerchList = [
          ...loadedState.merchList.map((m) {
            if (m.id == newMerch.id)
              return newMerch; // Заменяем изменённый мерч
            return m; // Возвращаем остальные
          }),
        ];
        emit(MerchLoaded(merchList: newMerchList));
      } catch (e) {
        emit(MerchError(error: e));
      }
    }, transformer: _debounceTransformer(const Duration(milliseconds: 100)));
  }
}
