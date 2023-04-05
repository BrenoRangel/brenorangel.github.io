import 'package:flutter/material.dart';

import 'constants.dart';
import 'item.dart';

String buildTagLogo(String tag) {
  return '![$tag](${tagIcons[tag]!.assetName})';
}

String buildContent(Item item) {
  final buffer = StringBuffer();
  buffer.writeln('# ${item.title}\n');
  if (!item.published) buffer.writeln('Não publicado. ');
  if (item.obs != null) buffer.writeln('${item.obs}\n');
  buffer.writeln(
    [
      ...[
        item.android,
        item.iOS
      ]..removeWhere(
          (element) => [
            null
          ].contains(element),
        )
    ].map((m) => '[${newMethod(m)}]($m)').join(', '),
  );
  buffer.writeln('\n');
  buffer.writeln(item.tags.map(buildTagLogo).join(' '));
  return buffer.toString();
}

String newMethod(String? m) {
  var host = Uri.parse('$m').host;
  switch (host) {
    case 'play.google.com':
      host = 'Play Store';
      break;
    case 'apps.apple.com':
      host = 'App Store';
      break;
  }
  host = '$host ↗';
  return host;
}

Widget markdowImageBuilder(uri, title, alt) {
  return Tooltip(
    message: alt,
    child: Image.network(
      uri.toString(),
      width: 20,
      height: 20,
    ),
  );
}

