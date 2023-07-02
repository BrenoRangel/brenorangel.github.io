import 'dart:math';
import 'dart:ui';

import 'package:device_frame/device_frame.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart' as md;
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import 'constants.dart';
import 'item.dart';

class ItemView extends StatefulWidget {
  final IItem item;

  const ItemView({super.key, required this.item});

  @override
  State<ItemView> createState() => _ItemViewState();
}

class _ItemViewState extends State<ItemView> {
  final ScrollController controller = ScrollController();
  final RxInt page = 0.obs;
  bool hasScrollbar = false;

  @override
  Widget build(BuildContext context) {
    var constraints = BoxConstraints(
      maxHeight: min(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height) / 2,
      maxWidth: MediaQuery.of(context).size.width - 16,
    );
    WidgetsBinding.instance.addPostFrameCallback((duration) {
      setState(() {
        hasScrollbar = (controller.hasClients && controller.position.maxScrollExtent > 0);
      });
    });
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
              data: buildContent(widget.item),
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
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                controller: controller,
                child: Wrap(
                  clipBehavior: Clip.none,
                  spacing: 8,
                  runSpacing: 8,
                  runAlignment: WrapAlignment.center,
                  alignment: WrapAlignment.center,
                  children: switch (widget.item) {
                    (AppItem app) => [
                        buildMock(
                          constraints: constraints,
                          child: app.child,
                        )
                      ],
                    (Item d) => buildChildren(context, constraints),
                    _ => [
                        const Placeholder()
                      ]
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> buildChildren(BuildContext context, BoxConstraints constraints) {
    return List.generate(
      widget.item.imagesUrls!.length,
      (index) {
        Widget image = Image.network(
          widget.item.imagesUrls![index],
          fit: BoxFit.fill,
        );
        return Padding(
          padding: EdgeInsets.only(
            top: 8,
            bottom: hasScrollbar ? 16 : 0,
          ),
          child: buildMock(
            constraints: constraints,
            child: image,
            index: index,
          ),
        );
      },
    );
  }

  Widget buildMock({
    required BoxConstraints constraints,
    required Widget child,
    int index = 0,
  }) {
    return GestureDetector(
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
                          child: switch (widget.item) {
                            (AppItem item) => buildDeviceFrame(child),
                            _ => Stack(
                                alignment: Alignment.center,
                                children: [
                                  PageView(
                                    controller: PageController(initialPage: index),
                                    onPageChanged: (int page) => this.page.value = page,
                                    children: widget.item.imagesUrls!.map(
                                      (url) {
                                        Widget child = Image.network(
                                          url,
                                          fit: BoxFit.contain,
                                        );
                                        if (widget.item.deviceFrameIdentifier != null) {
                                          child = buildDeviceFrame(child);
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
                                        if (page.value < widget.item.imagesUrls!.length - 1)
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
                          }),
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
        child: widget.item.deviceFrameIdentifier != null
            ? DeviceFrame(
                orientation: Orientation.values.byName(widget.item.deviceFrameOrientation),
                isFrameVisible: widget.item.deviceFrameIdentifier != null,
                device: Devices.all.firstWhere((e) => e.name == widget.item.deviceFrameIdentifier),
                screen: child,
              )
            : child,
      ),
    );
  }

  DeviceFrame buildDeviceFrame(Widget child) {
    return DeviceFrame(
      orientation: Orientation.values.byName(widget.item.deviceFrameOrientation),
      isFrameVisible: widget.item.deviceFrameIdentifier != null,
      device: Devices.all.firstWhere((e) => e.name == widget.item.deviceFrameIdentifier),
      screen: child,
    );
  }

  String buildTagLogo(String tag) => '![$tag](${tagIcons[tag]})';

  String buildContent(IItem item) {
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
