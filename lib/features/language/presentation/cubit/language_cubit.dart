import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit({required String initialLanguageCode})
    : super(LanguageState(initialLanguageCode));

  void changeLanguage(String languageCode) => emit(LanguageState(languageCode));
}
