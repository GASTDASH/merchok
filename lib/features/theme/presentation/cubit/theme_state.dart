part of 'theme_cubit.dart';

class ThemeState extends Equatable {
  const ThemeState(this.themeStyle);

  final ThemeStyle themeStyle;

  @override
  List<Object> get props => [themeStyle];
}
