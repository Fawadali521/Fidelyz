import 'package:flutter/material.dart';

class RotatingCoin extends StatefulWidget {
  const RotatingCoin({super.key});

  @override
  _RotatingCoinState createState() => _RotatingCoinState();
}

class _RotatingCoinState extends State<RotatingCoin> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..repeat(); // This makes the animation run indefinitely
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform(
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001) // This value gives the perspective effect
            ..rotateY(2 * 3.14159 * _controller.value),
          alignment: Alignment.center,
          child: child,
        );
      },
      child: Image.asset(
        "assets/icons/coin.png",
        height: 30,
        width: 30,
        fit: BoxFit.contain,
      ),
    );
  }
}
