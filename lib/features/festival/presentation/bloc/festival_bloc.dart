import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merchok/features/festival/festival.dart';
import 'package:merchok/features/settings/domain/domain.dart';
import 'package:merchok/generated/l10n.dart';
import 'package:uuid/uuid.dart';

part 'festival_event.dart';
part 'festival_state.dart';

class FestivalBloc extends Bloc<FestivalEvent, FestivalState> {
  final FestivalRepository _festivalRepository;
  final SettingsRepository _settingsRepository;

  FestivalBloc({
    required FestivalRepository festivalRepository,
    required SettingsRepository settingsRepository,
  }) : _festivalRepository = festivalRepository,
       _settingsRepository = settingsRepository,
       super(FestivalInitial()) {
    String? savedSelectedFestivalId = _settingsRepository.selectedFestivalId;

    on<FestivalLoad>((event, emit) async {
      Festival? selectedFestival = getSelectedFestival();

      try {
        emit(FestivalLoading(message: S.current.festivalLoading));

        final festivalList = await _festivalRepository.getFestivals();

        // Если есть сохранённый выбранный фестиваль (при запуске)
        if (savedSelectedFestivalId != null) {
          // Найти этот фестиваль и сделать его выбранным
          selectedFestival = festivalList.firstWhereOrNull(
            (festival) => festival.id == savedSelectedFestivalId,
          );

          // Если не был найден фестиваль => он был удалён => убираем сохранённую запись в Shared Preferences
          if (selectedFestival == null) {
            _settingsRepository.clearSelectedFestivalId();
          }

          // Сохранённый выбранный фестиваль больше не нужен
          savedSelectedFestivalId = null;
        }

        emit(
          FestivalLoaded(
            festivalList: festivalList,
            selectedFestival: selectedFestival,
          ),
        );
      } catch (e) {
        emit(FestivalError(error: e));
      }
    });
    on<FestivalAdd>((event, emit) async {
      Festival? selectedFestival = getSelectedFestival();

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

        await loadFestivals(emit, selectedFestival);
      } catch (e) {
        emit(FestivalError(error: e));
      }
    });
    on<FestivalEdit>((event, emit) async {
      Festival? selectedFestival = getSelectedFestival();

      try {
        emit(FestivalLoading(message: S.current.festivalChangeInfo));

        await _festivalRepository.editFestival(event.festival);

        // Если изменяется выбранный фестиваль
        if (selectedFestival?.id == event.festival.id) {
          selectedFestival = event.festival;
        }

        await loadFestivals(emit, selectedFestival);
      } catch (e) {
        emit(FestivalError(error: e));
      }
    });
    on<FestivalDelete>((event, emit) async {
      Festival? selectedFestival = getSelectedFestival();

      // Если удаляется выбранный фестиваль
      if (selectedFestival?.id == event.festivalId) selectedFestival = null;

      try {
        emit(FestivalLoading(message: S.current.festivalDeleting));
        await _festivalRepository.deleteFestival(event.festivalId);

        // Если удаляется сохранённый выбранный фестиваль
        if (_settingsRepository.selectedFestivalId == event.festivalId) {
          await _settingsRepository.clearSelectedFestivalId();
        }

        await loadFestivals(emit, selectedFestival);
      } catch (e) {
        emit(FestivalError(error: e));
      }
    });
    on<FestivalSelect>((event, emit) async {
      Festival? selectedFestival = getSelectedFestival();

      try {
        emit(FestivalLoading(message: S.current.festivalSelecting));

        // Если был выбран уже выбранный фестиваль
        if (selectedFestival?.id == event.festival.id) {
          // Очистить выделение
          await _settingsRepository.clearSelectedFestivalId();

          await loadFestivals(emit, null);
        } else {
          // Сохранение ID фестиваля в Shared Preferences
          await _settingsRepository.setSelectedFestivalId(event.festival.id);

          await loadFestivals(emit, event.festival);
        }
      } catch (e) {
        emit(FestivalError(error: e));
      }
    });
  }

  /// Получение списка фестивалей и вызов состояния [FestivalLoaded]
  Future<void> loadFestivals(
    Emitter<FestivalState> emit,
    Festival? selectedFestival,
  ) async {
    final festivalList = await _festivalRepository.getFestivals();
    emit(
      FestivalLoaded(
        festivalList: festivalList,
        selectedFestival: selectedFestival,
      ),
    );
  }

  /// Получение выбранного в данный момент фестиваля. Если фестиваль не был найден, возвращает [null]
  Festival? getSelectedFestival() {
    Festival? selectedFestival;
    if (state is FestivalLoaded) {
      selectedFestival = (state as FestivalLoaded).selectedFestival;
    }
    return selectedFestival;
  }
}
