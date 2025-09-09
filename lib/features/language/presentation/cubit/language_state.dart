part of 'language_cubit.dart';

class LanguageState extends Equatable {
  const LanguageState({this.languageCode});

  final String? languageCode;

  @override
  List<Object> get props => [languageCode ?? ''];
}
