import 'package:flutter/material.dart';
import 'package:merchok/generated/l10n.dart';
import 'package:url_launcher/url_launcher.dart';

class LinkText extends StatelessWidget {
  const LinkText({super.key, required this.url, this.textStyle});

  final String url;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () async {
        final s = S.of(context);
        final scaffoldMessenger = ScaffoldMessenger.of(context);

        final Uri uri = Uri.parse(url);

        if (!await launchUrl(uri)) {
          scaffoldMessenger.hideCurrentSnackBar();
          scaffoldMessenger.showSnackBar(
            SnackBar(
              backgroundColor: theme.colorScheme.error,
              content: Text(s.couldntOpenPage),
            ),
          );
        }
      },
      child: Text(
        url,
        style:
            textStyle ??
            theme.textTheme.bodyMedium?.copyWith(color: Colors.blue),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
