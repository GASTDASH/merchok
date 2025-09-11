import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merchok/features/festival/festival.dart';
import 'package:merchok/features/settings/settings.dart';

class CurrentFestivalCubit extends Cubit<Festival?> {
  CurrentFestivalCubit({
    required FestivalRepository festivalRepository,
    required SettingsRepository settingsRepository,
  }) : _settingsRepository = settingsRepository,
       _festivalRepository = festivalRepository,
       super(null) {
    _loadSelectedFestival();
  }

  final FestivalRepository _festivalRepository;
  final SettingsRepository _settingsRepository;

  /// Получение сохранённого выбранного фестиваля
  Future<void> _loadSelectedFestival() async {
    final savedSelectedFestivalId = _settingsRepository.selectedFestivalId;

    // Если нет сохранённого выбранного фестиваля
    if (savedSelectedFestivalId == null) return;

    try {
      final festivalList = await _festivalRepository.getFestivals();

      // Найти фестиваль
      final savedSelectedFestival = festivalList.firstWhereOrNull(
        (f) => f.id == savedSelectedFestivalId,
      );

      // Если не был найден фестиваль => он был как-то удалён => удаляем сохранённую запись в Shared Preferences
      if (savedSelectedFestival == null) {
        _settingsRepository.clearSelectedFestivalId();
      } else {
        emit(savedSelectedFestival);
      }
    } catch (e) {
      // TODO: Обработка ошибки
    }
  }

  /// Выбор фестиваля
  Future<void> selectFestival(Festival festival) async {
    emit(festival);
    await _settingsRepository.setSelectedFestivalId(festival.id);
  }

  /// Удаление выбранного фестиваля
  Future<void> clearSelection() async {
    emit(null);
    await _settingsRepository.clearSelectedFestivalId();
  }

  /// При изменении фестиваля
  void handleFestivalUpdated(Festival updatedFestival) {
    if (state?.id == updatedFestival.id) emit(updatedFestival);
  }

  /// При удалении фестиваля
  Future<void> handleFestivalDeleted(String deletedFestivalId) async {
    if (state?.id == deletedFestivalId) await clearSelection();
  }
}
