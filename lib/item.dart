class Item {
  final String title;
  String? android, iOS, obs;
  final List<String> imagesUrls, tags;
  final bool published;

  Item({
    required this.imagesUrls,
    required this.title,
    this.tags = const [],
    this.iOS,
    this.android,
    this.obs,
    this.published = true,
  });
}
