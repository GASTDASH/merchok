import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merchok/features/settings/settings.dart';
import 'package:merchok/theme/theme.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit({
    required ThemeStyle initialThemeStyle,
    required SettingsRepository settingsRepository,
  }) : _settingsRepository = settingsRepository,
       super(ThemeState(ThemeStyle.light)) {
    _getSavedThemeStyle();
  }

  final SettingsRepository _settingsRepository;

  Future<void> changeTheme(ThemeStyle themeStyle) async {
    emit(ThemeState(themeStyle));
    await _settingsRepository.setThemeStyle(themeStyle);
  }

  void _getSavedThemeStyle() =>
      emit(ThemeState(_settingsRepository.getCurrentThemeStyle));
}
