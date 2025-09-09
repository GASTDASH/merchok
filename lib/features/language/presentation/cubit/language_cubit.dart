import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merchok/features/settings/settings.dart';

part 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit({
    String? initialLanguageCode,
    required SettingsRepository settingsRepository,
  }) : _settingsRepository = settingsRepository,
       super(LanguageState(languageCode: initialLanguageCode)) {
    _getSavedLanguageCode();
  }

  final SettingsRepository _settingsRepository;

  Future<void> changeLanguage(String? languageCode) async {
    emit(LanguageState(languageCode: languageCode));
    await _settingsRepository.setLanguageCode(languageCode);
  }

  void _getSavedLanguageCode() => emit(
    LanguageState(languageCode: _settingsRepository.currentLanguageCode),
  );
}
