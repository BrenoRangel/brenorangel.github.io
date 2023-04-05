import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:url_launcher/url_launcher.dart';

import '/item.dart';
import '/utils.dart';

class Header extends StatelessWidget {
  final Item item;
  const Header(
    this.item, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MarkdownBody(
      data: buildContent(item),
      imageBuilder: markdowImageBuilder,
      onTapLink: (text, href, title) => launchUrl(
        Uri.parse('$href'),
      ),
    );
  }
}
