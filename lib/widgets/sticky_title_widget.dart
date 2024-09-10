import 'dart:math';

import 'package:flutter/material.dart';

class SliverExpansionTile extends StatelessWidget {
  const SliverExpansionTile({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          const StickyTitleWidget(
            title: Text('Food Category'),
          ),
        ],
      ),
    );
  }
}

class StickyTitleWidget extends StatelessWidget {
  const StickyTitleWidget({super.key, required this.title});
  final Widget title;

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _StickyTitleDelegate(
        minHeight: 80,
        maxHeight: 100,
        child: title,
      ),
    );
  }
}

class _StickyTitleDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  _StickyTitleDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  double get maxExtent => max(maxHeight, minHeight);

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return minHeight != minHeight || maxHeight != maxHeight || child != child;
  }
}
