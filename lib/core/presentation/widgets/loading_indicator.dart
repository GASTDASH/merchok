import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key, this.size = 70});

  final double size;

  @override
  Widget build(BuildContext context) {
    return SpinKitSpinningLines(
      color: Theme.of(context).colorScheme.onSurface,
      size: size,
    );
  }
}
