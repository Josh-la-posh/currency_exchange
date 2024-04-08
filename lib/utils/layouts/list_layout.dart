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
        itemCount: itemCount,
        shrinkWrap: true,
        itemBuilder: itemBuilder
    );
  }
}