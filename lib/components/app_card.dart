import 'package:flutter/material.dart';

import '/constants.dart';

class AppCard extends StatelessWidget {
  final List<Widget> children;
  const AppCard({
    this.children = const [],
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
          children: children,
        ),
      ),
    );
  }
}
