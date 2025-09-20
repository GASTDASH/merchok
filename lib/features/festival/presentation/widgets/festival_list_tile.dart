import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merchok/core/core.dart';
import 'package:merchok/features/festival/festival.dart';
import 'package:merchok/generated/l10n.dart';

class FestivalListTile extends StatelessWidget {
  const FestivalListTile({
    super.key,
    required this.festival,
    this.onTap,
    this.onLongPress,
    this.selected = false,
  });

  final Festival festival;
  final VoidCallback? onLongPress;
  final VoidCallback? onTap;
  final bool selected;

  Future<void> editFestivalName(BuildContext context) async {
    final defaultName = S.of(context).untitled;
    final bloc = context.read<FestivalBloc>();

    Festival? newFestival = await showDialog(
      context: context,
      builder: (context) => EditFestivalDialog(previousFestival: festival),
    );
    if (newFestival == null) return;
    if (newFestival.name.isEmpty) {
      newFestival = festival.copyWith(name: defaultName);
    }

    bloc.add(FestivalEdit(festival: newFestival));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      onTap: onTap,
      onLongPress: onLongPress,
      contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
      trailing: selected
          ? Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.greenAccent),
              ),
              child: Icon(Icons.done, color: Colors.greenAccent),
            )
          : null,
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
            child: BaseSvgIcon(context, IconNames.edit, height: 16),
          ),
        ],
      ),
      subtitle: Text(
        '${S.of(context).eventDate}: ${festival.startDate.toCompactString()} - ${festival.endDate.toCompactString()}',
        style: theme.textTheme.bodyMedium?.copyWith(color: theme.hintColor),
      ),
    );
  }
}
