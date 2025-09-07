import 'package:flutter/material.dart';
import 'package:merchok/core/core.dart';
import 'package:merchok/generated/l10n.dart';

class ImportBottomSheet extends StatelessWidget {
  const ImportBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(32),
      ),
      height: 300,
      padding: EdgeInsets.all(16),
      child: Column(
        spacing: 12,
        children: [
          Text(
            S.of(context).whereToImportFrom,
            style: theme.textTheme.titleLarge?.copyWith(fontSize: 20),
          ),
          Expanded(
            child: Row(
              spacing: 12,
              children: [
                Expanded(
                  child: BaseContainer(
                    onTap: () {},
                    height: 150,
                    elevation: 8,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          S.of(context).fromExcel,
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(S.of(context).notAvailableYet),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: BaseContainer(
                    onTap: () {},
                    height: 150,
                    elevation: 8,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          S.of(context).fromCSV,
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(S.of(context).recommended),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
