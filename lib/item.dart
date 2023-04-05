class Item {
  final String title, deviceFrameOrientation;
  String? android, iOS, obs, deviceFrameIdentifier;
  List<String>? imagesUrls;
  final List<String> tags;
  final bool published;

  Item({
    this.imagesUrls,
    required this.title,
    this.deviceFrameIdentifier,
    this.deviceFrameOrientation = 'portrait',
    this.tags = const [],
    this.iOS,
    this.android,
    this.obs,
    this.published = true,
  });
}
