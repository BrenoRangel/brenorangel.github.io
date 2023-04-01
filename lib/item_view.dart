import 'dart:ui';

import 'package:device_frame/device_frame.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart' as md;
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import 'constants.dart';
import 'item.dart';

class ItemView extends StatelessWidget {
  final Item item;

  ItemView({super.key, required this.item});

  final ScrollController controller = ScrollController();
  final RxBool hasScrollbar = false.obs;
  final RxInt page = 0.obs;

  @override
  Widget build(BuildContext context) {
    var constraints = BoxConstraints(
      maxHeight: MediaQuery.of(context).size.height / 2,
      maxWidth: MediaQuery.of(context).size.width - 16,
    );
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius,
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
              controller: controller,
              child: NotificationListener<ScrollMetricsNotification>(
                onNotification: (scrollNotification) {
                  hasScrollbar.value = (scrollNotification.metrics.maxScrollExtent > 0);
                  return true;
                },
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  controller: controller,
                  child: Wrap(
                    clipBehavior: Clip.none,
                    spacing: 8,
                    runSpacing: 8,
                    runAlignment: WrapAlignment.start,
                    children: List.generate(
                      item.imagesUrls.length,
                      (index) {
                        Widget image = Image.network(
                          item.imagesUrls[index],
                          fit: BoxFit.fill,
                        );
                        return Padding(
                          padding: EdgeInsets.only(
                            top: 8,
                            bottom: hasScrollbar.value ? 16 : 0,
                          ),
                          child: GestureDetector(
                            onTap: () {
                              page.value = index;
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return GestureDetector(
                                    onTap: () => Navigator.pop(context),
                                    child: LayoutBuilder(
                                      builder: (context, snapshot) {
                                        return BackdropFilter(
                                          filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                                          child: AlertDialog(
                                            elevation: 0,
                                            contentPadding: EdgeInsets.zero,
                                            insetPadding: const EdgeInsets.all(8),
                                            backgroundColor: Colors.transparent,
                                            shadowColor: Colors.transparent,
                                            content: SizedBox(
                                              width: snapshot.maxWidth,
                                              height: snapshot.maxHeight,
                                              child: Stack(
                                                alignment: Alignment.center,
                                                children: [
                                                  PageView(
                                                    controller: PageController(initialPage: index),
                                                    onPageChanged: (int page) => this.page.value = page,
                                                    children: item.imagesUrls.map(
                                                      (url) {
                                                        Widget child = Image.network(
                                                          url,
                                                          fit: BoxFit.contain,
                                                        );
                                                        if (item.deviceFrameIdentifier != null) {
                                                          child = DeviceFrame(
                                                            orientation: Orientation.values.byName(item.deviceFrameOrientation),
                                                            isFrameVisible: item.deviceFrameIdentifier != null,
                                                            device: Devices.all.firstWhere((e) => e.name == item.deviceFrameIdentifier),
                                                            screen: child,
                                                          );
                                                        }
                                                        return Padding(
                                                          padding: const EdgeInsets.all(8.0),
                                                          child: InteractiveViewer(
                                                            maxScale: 4,
                                                            minScale: 0.25,
                                                            child: child,
                                                          ),
                                                        );
                                                      },
                                                    ).toList(),
                                                  ),
                                                  Obx(
                                                    () => Row(
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                        if (page.value > 0)
                                                          const Material(
                                                            color: Colors.transparent,
                                                            elevation: 4,
                                                            child: Icon(
                                                              Icons.chevron_left,
                                                              color: Colors.yellow,
                                                            ),
                                                          ),
                                                        const Spacer(),
                                                        if (page.value < item.imagesUrls.length - 1)
                                                          const Material(
                                                            color: Colors.transparent,
                                                            elevation: 4,
                                                            child: Icon(
                                                              Icons.chevron_right,
                                                              color: Colors.yellow,
                                                            ),
                                                          ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                },
                              );
                            },
                            child: ConstrainedBox(
                              constraints: constraints,
                              child: item.deviceFrameIdentifier != null
                                  ? DeviceFrame(
                                      orientation: Orientation.values.byName(item.deviceFrameOrientation),
                                      isFrameVisible: item.deviceFrameIdentifier != null,
                                      device: Devices.all.firstWhere((e) => e.name == item.deviceFrameIdentifier),
                                      screen: image,
                                    )
                                  : image,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
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
