import 'package:flutter/material.dart';
import 'package:markdown_widget/markdown_widget.dart';
import 'package:merchok/core/core.dart';
import 'package:merchok/generated/l10n.dart';

class MarkdownScreen extends StatelessWidget {
  const MarkdownScreen({super.key, required this.assetName});

  final String assetName;

  Future<String> getMarkdown(BuildContext context) async =>
      await DefaultAssetBundle.of(context).loadString(assetName);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getMarkdown(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: LoadingIndicator());
          }
          if (snapshot.hasData) {
            return MarkdownWidget(
              padding: const EdgeInsets.all(24),
              data: snapshot.data!,
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(S.of(context).loadingError),
                  Text(snapshot.error.toString()),
                ],
              ),
            );
          } else {
            return Center(child: Text(S.of(context).noDataToDisplay));
          }
        },
      ),
    );
  }
}
