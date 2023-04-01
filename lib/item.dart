class Item {
  final String title, deviceFrameOrientation;
  String? android, iOS, obs, deviceFrameIdentifier;
  final List<String> imagesUrls, tags;
  final bool published;

  Item({
    required this.imagesUrls,
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
