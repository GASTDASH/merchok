import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merchok/theme/theme.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit({required ThemeStyle themeStyle}) : super(ThemeState(themeStyle));

  void changeTheme(ThemeStyle themeStyle) => emit(ThemeState(themeStyle));
}
