import 'package:flutter/material.dart';
import 'package:swappr/utils/shared/loader/svg.dart';

class Loader extends StatefulWidget {
  const Loader({Key? key}) : super(key: key);

  @override
  State<Loader> createState() => _LoaderState();
}

class _LoaderState extends State<Loader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<double> _widthAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      reverseDuration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);

    _opacityAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    _widthAnimation = Tween<double>(begin: 200, end: 100).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return AnimatedOpacity(
            opacity: _opacityAnimation.value,
            duration: const Duration(milliseconds: 500),
            child: AnimatedContainer(
              width: _widthAnimation.value,
              duration: const Duration(milliseconds: 500),
              child: Logo(width: double.infinity),
            ),
          );
        },
      ),
    );
  }
}
