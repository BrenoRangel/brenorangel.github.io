import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart' as md;
import 'package:url_launcher/url_launcher.dart';

import 'constants.dart';
import 'item.dart';
import 'theming.dart';

class ItemView extends StatelessWidget {
  final Item item;
  const ItemView({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    var constraints = BoxConstraints(
      maxHeight: MediaQuery.of(context).size.height / 2,
      maxWidth: MediaQuery.of(context).size.width - 16,
    );
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(
          color: Theme.of(context).disabledColor,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            md.MarkdownBody(
              data: buildContent(item),
              imageBuilder: (uri, title, alt) {
                return Tooltip(
                  message: alt,
                  child: Image.network(
                    uri.toString(),
                    width: 20,
                    height: 20,
                  ),
                );
              },
              onTapLink: (text, href, title) => launchUrl(
                Uri.parse('$href'),
              ),
            ),
            Scrollbar(
              thumbVisibility: true,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  runAlignment: WrapAlignment.start,
                  children: item.imagesUrls
                      .map(
                        (url) => Padding(
                          padding: const EdgeInsets.only(top: 8, bottom: 16),
                          child: GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (c) {
                                  return BackdropFilter(
                                    filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: AlertDialog(
                                        contentPadding: EdgeInsets.zero,
                                        content: Image.network(
                                          url.toString(),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            child: ClipRRect(
                              clipBehavior: Clip.antiAlias,
                              borderRadius: BorderRadius.circular(8),
                              child: ConstrainedBox(
                                constraints: constraints,
                                child: Image.network(
                                  url,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String buildTagLogo(String tag) => '![$tag](${tagIcons[tag]})';

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
}
