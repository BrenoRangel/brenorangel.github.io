import 'package:flutter/material.dart';

abstract interface class IItem {
  final String title, deviceFrameOrientation;
  final String? android, iOS, obs, deviceFrameIdentifier;
  final List<String>? imagesUrls;
  final List<String> tags;
  final bool published;

  const IItem({
    required this.title,
    this.imagesUrls,
    this.deviceFrameIdentifier,
    this.deviceFrameOrientation = 'portrait',
    this.tags = const [],
    this.iOS,
    this.android,
    this.obs,
    this.published = true,
  });
}

class Item extends IItem {
  const Item({
    required super.title,
    super.imagesUrls,
    super.deviceFrameIdentifier,
    super.deviceFrameOrientation = 'portrait',
    super.tags = const [],
    super.iOS,
    super.android,
    super.obs,
    super.published = true,
  });
}

class AppItem extends IItem {
  final Widget child;

  const AppItem({
    required super.title,
    super.deviceFrameIdentifier,
    super.deviceFrameOrientation = 'portrait',
    super.tags = const [],
    super.iOS,
    super.android,
    super.obs,
    super.published = true,
    required this.child,
  });
}
