import 'dart:developer';
import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merchok/core/core.dart';
import 'package:merchok/features/merch/merch.dart';
import 'package:merchok/generated/l10n.dart';
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
        emit(MerchLoading(message: S.current.merchLoading));
        log('${DateTime.now()} - getting merchList');
        final List<Merch> merchList = await _merchRepository.getMerches();
        log('${DateTime.now()} - got merchList');
        emit(MerchLoaded(merchList: merchList));
      } catch (e) {
        emit(MerchError(error: e));
      }
    });
    on<MerchAdd>((event, emit) async {
      try {
        emit(MerchLoading(message: S.current.merchCreating));
        await _merchRepository.editMerch(
          Merch(id: Uuid().v4(), name: S.current.untitled, price: 0),
        );
        add(MerchLoad());
      } catch (e) {
        emit(MerchError(error: e));
      }
    });
    on<MerchEdit>((event, emit) async {
      try {
        emit(MerchLoading(message: S.current.merchChangeInfo));

        await _merchRepository.editMerch(event.merch);
        add(MerchLoad());
      } catch (e) {
        emit(MerchError(error: e));
      }
    });
    on<MerchDelete>((event, emit) async {
      try {
        emit(MerchLoading(message: S.current.merchDeleting));
        await _merchRepository.deleteMerch(event.merchId);
        add(MerchLoad());
      } catch (e) {
        emit(MerchError(error: e));
      }
    });
    on<MerchImport>((event, emit) async {
      try {
        emit(MerchLoading(message: S.current.merchImporting));
        for (var merch in event.merchList) {
          await _merchRepository.editMerch(merch);
        }
        add(MerchLoad());
      } catch (e) {
        emit(MerchError(error: e));
      }
    });
    on<MerchUpdateImage>((event, emit) async {
      try {
        emit(MerchLoading(message: S.current.merchUpdatingImage));

        final compressedImage = await ImageUtils.compressImage(event.image);
        final thumbnailImage = await ImageUtils.createThumbnail(event.image);

        await _merchRepository.editMerch(
          event.merch.copyWith(
            image: compressedImage,
            thumbnail: thumbnailImage,
          ),
        );
        add(MerchLoad());
      } catch (e) {
        emit(MerchError(error: e));
      }
    });
  }
}
