import 'package:basement/basement.dart';
import 'package:flutter/material.dart';

import '/item.dart';
import 'app_card.dart';
import 'carousel.dart';
import 'header.dart';

class ItemView extends StatefulWidget {
  final Item item;

  const ItemView({super.key, required this.item});

  @override
  State<ItemView> createState() => _ItemViewState();
}

class _ItemViewState extends State<ItemView> {
  @override
  Widget build(BuildContext context) {
    return AppCard(
      children: [
        Header(widget.item),
        gap,
        Carousel(widget.item)
      ],
    );
  }
}
