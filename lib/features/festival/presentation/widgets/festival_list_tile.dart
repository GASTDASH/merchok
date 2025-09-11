import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:merchok/core/core.dart';
import 'package:merchok/features/festival/festival.dart';
import 'package:merchok/generated/l10n.dart';

class FestivalListTile extends StatelessWidget {
  const FestivalListTile({
    super.key,
    required this.festival,
    this.onTap,
    this.onLongPress,
  });

  final Festival festival;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      onTap: onTap,
      onLongPress: onLongPress,
      contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
      title: Row(
        spacing: 8,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            festival.name,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          GestureDetector(
            onTap: () async => await editFestivalName(context),
            child: SvgPicture.asset(
              IconNames.edit,
              colorFilter: ColorFilter.mode(
                theme.colorScheme.onSurface,
                BlendMode.srcIn,
              ),
              height: 16,
            ),
          ),
        ],
      ),
      subtitle: Text(
        '${S.of(context).eventDate}: ${festival.startDate.toCompactString()} - ${festival.endDate.toCompactString()}',
        style: theme.textTheme.bodyLarge?.copyWith(
          fontWeight: FontWeight.w300,
          color: theme.hintColor,
        ),
      ),
    );
  }

  Future<void> editFestivalName(BuildContext context) async {
    final bloc = context.read<FestivalBloc>();

    Festival? newFestival = await showDialog(
      context: context,
      builder: (context) => EditFestivalDialog(previousFestival: festival),
    );
    if (newFestival == null) return;
    if (newFestival.name == '') {
      newFestival = festival.copyWith(name: 'Без названия');
    }

    bloc.add(FestivalEdit(festival: newFestival));
  }
}
