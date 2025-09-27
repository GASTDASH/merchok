import 'package:flutter/material.dart';
import 'package:merchok/core/core.dart';
import 'package:skeletonizer/skeletonizer.dart';

class StatInfoCard extends StatelessWidget {
  const StatInfoCard({super.key, required this.name, this.value});

  final String name;
  final String? value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BaseContainer(
      padding: EdgeInsets.all(24),
      boxShadow: [
        BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 4)),
      ],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Skeletonizer(
            enabled: (value == null),
            child: SizedBox(
              height: 40,
              child: FittedBox(
                alignment: AlignmentGeometry.centerLeft,
                child: Text(
                  value ?? '9999',
                  style: theme.textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
          FittedBox(child: Text(name, style: theme.textTheme.bodyLarge)),
        ],
      ),
    );
  }
}
