import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merchok/features/festival/festival.dart';
import 'package:merchok/generated/l10n.dart';
import 'package:uuid/uuid.dart';

part 'festival_event.dart';
part 'festival_state.dart';

class FestivalBloc extends Bloc<FestivalEvent, FestivalState> {
  final FestivalRepository _festivalRepository;

  FestivalBloc({required FestivalRepository festivalRepository})
    : _festivalRepository = festivalRepository,
      super(FestivalInitial()) {
    on<FestivalLoad>((event, emit) async {
      try {
        emit(FestivalLoading(message: S.current.festivalLoading));
        final festivalList = await _festivalRepository.getFestivals();
        emit(FestivalLoaded(festivalList: festivalList));
      } catch (e) {
        emit(FestivalError(error: e));
      }
    });
    on<FestivalAdd>((event, emit) async {
      try {
        emit(FestivalLoading(message: S.current.festivalCreating));
        await _festivalRepository.editFestival(
          Festival(
            id: Uuid().v4(),
            name: event.festivalName,
            startDate: DateTime.now(),
            endDate: DateTime.now(),
          ),
        );
        add(FestivalLoad());
      } catch (e) {
        emit(FestivalError(error: e));
      }
    });
    on<FestivalEdit>((event, emit) async {
      try {
        emit(FestivalLoading(message: S.current.festivalChangeInfo));
        await _festivalRepository.editFestival(event.festival);
        add(FestivalLoad());
      } catch (e) {
        emit(FestivalError(error: e));
      }
    });
    on<FestivalDelete>((event, emit) async {
      try {
        emit(FestivalLoading(message: S.current.festivalDeleting));
        await _festivalRepository.deleteFestival(event.festivalId);
        add(FestivalLoad());
      } catch (e) {
        emit(FestivalError(error: e));
      }
    });
  }
}
