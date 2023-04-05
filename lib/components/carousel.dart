import 'dart:ui';

import 'package:device_frame/device_frame.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/item.dart';
import '/theming.dart';

class Carousel extends StatefulWidget {
  final Item item;

  const Carousel(
    this.item, {
    super.key,
  });

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  final RxInt page = 0.obs;

  var scrollController = ScrollController();
  bool hasScrollbar = false;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((duration) {
      setState(() {
        hasScrollbar = (scrollController.hasClients && scrollController.position.maxScrollExtent > 0);
      });
    });
    return Scrollbar(
      controller: scrollController,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        controller: scrollController,
        child: Wrap(
          clipBehavior: Clip.none,
          spacing: 8,
          runSpacing: 8,
          runAlignment: WrapAlignment.start,
          children: List.generate(
            widget.item.imagesUrls!.length,
            (index) {
              Widget image = Image.network(
                widget.item.imagesUrls![index],
                fit: BoxFit.fill,
              );
              return Padding(
                padding: EdgeInsets.only(
                  bottom: hasScrollbar ? 16 : 0,
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
                                          onPageChanged: (int index) => page.value = index,
                                          children: widget.item.imagesUrls!.map(
                                            (url) {
                                              Widget child = Image.network(
                                                url,
                                                fit: BoxFit.contain,
                                              );
                                              if (widget.item.deviceFrameIdentifier != null) {
                                                child = DeviceFrame(
                                                  orientation: Orientation.values.byName(widget.item.deviceFrameOrientation),
                                                  isFrameVisible: widget.item.deviceFrameIdentifier != null,
                                                  device: Devices.all.firstWhere((e) => e.name == widget.item.deviceFrameIdentifier),
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
                    constraints: getConstraints(context),
                    child: widget.item.deviceFrameIdentifier != null
                        ? DeviceFrame(
                            orientation: Orientation.values.byName(widget.item.deviceFrameOrientation),
                            isFrameVisible: widget.item.deviceFrameIdentifier != null,
                            device: Devices.all.firstWhere((e) => e.name == widget.item.deviceFrameIdentifier),
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
    );
  }
}
