import 'package:flutter/material.dart';


class TListLayout extends StatelessWidget {
  const TListLayout({
    super.key,
    required this.itemCount,
    required this.itemBuilder
  });

  final int itemCount;
  final Widget? Function(BuildContext, int) itemBuilder;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: itemCount,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: itemBuilder
    );
  }
}