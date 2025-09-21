import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

mixin SaveScrollPositionMixin {
  double? savedScrollPosition;
  final ScrollController scrollController = ScrollController();

  void saveScrollPosition() {
    if (scrollController.hasClients) {
      savedScrollPosition = scrollController.offset;
      GetIt.I<Talker>().debug(
        'Called saveScrollPosition()\n'
        'savedScrollPosition = $savedScrollPosition',
      );
    }
  }

  void restoreScrollPosition() {
    if (savedScrollPosition != null && scrollController.hasClients) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (scrollController.hasClients) {
          scrollController.animateTo(
            savedScrollPosition!,
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        }
      });
      GetIt.I<Talker>().debug(
        'Called restoreScrollPosition()\n'
        'savedScrollPosition = $savedScrollPosition',
      );
    }
  }
}
