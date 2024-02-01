// import 'package:flutter/material.dart';
//
// class AnimatedPoints extends StatefulWidget {
//   final int endPoints;
//
//   const AnimatedPoints({super.key, required this.endPoints});
//
//   @override
//   _AnimatedPointsState createState() => _AnimatedPointsState();
// }
//
// class _AnimatedPointsState extends State<AnimatedPoints> with TickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<int> _pointsAnimation;
//   late AnimationController _scaleController;
//   late Animation<double> _scaleAnimation;
//
//   @override
//   void initState() {
//     super.initState();
//
//     _controller = AnimationController(
//       duration: Duration(seconds: 2),
//       vsync: this,
//     );
//
//     _pointsAnimation = IntTween(begin: 0, end: widget.endPoints).animate(
//       CurvedAnimation(parent: _controller, curve: Curves.bounceIn),
//     )
//       ..addListener(() {
//         setState(() {});
//       })
//       ..addStatusListener((status) {
//         if (status == AnimationStatus.completed) {
//           _scaleController.forward();
//         }
//       });
//
//     _scaleController = AnimationController(
//       duration: const Duration(milliseconds: 500),
//       vsync: this,
//     );
//
//     _scaleAnimation = Tween<double>(begin: 1.0, end: 1.4)
//         .chain(
//           CurveTween(curve: Curves.bounceInOut),
//         )
//         .animate(_scaleController)
//       ..addStatusListener((status) {
//         if (status == AnimationStatus.completed) {
//           _scaleController.reverse();
//         }
//       });
//
//     _controller.forward();
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     _scaleController.dispose();
//     super.dispose();
//   }
//
//   List<Widget> _buildDigits(int value) {
//     return value
//         .toString()
//         .split('')
//         .map((digit) => Text(
//               digit,
//               style: const TextStyle(
//                 color: Colors.white,
//                 fontSize: 24,
//                 fontWeight: FontWeight.w600,
//               ), // Use your custom style here
//             ))
//         .toList();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return ScaleTransition(
//       scale: _scaleAnimation,
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: _buildDigits(_pointsAnimation.value),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

import '../../../../styles.dart';

class AnimatedPoints extends StatefulWidget {
  final int endPoints;

  const AnimatedPoints({super.key, required this.endPoints});

  @override
  _AnimatedPointsState createState() => _AnimatedPointsState();
}

class _AnimatedPointsState extends State<AnimatedPoints> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _pointsAnimation;
  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );

    _pointsAnimation = IntTween(begin: 0, end: widget.endPoints).animate(
      CurvedAnimation(parent: _controller, curve: Curves.bounceIn),
    )
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _scaleController.forward();
        }
      });

    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.4)
        .chain(
          CurveTween(curve: Curves.bounceInOut),
        )
        .animate(_scaleController)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _scaleController.reverse();
        }
      });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  List<Widget> _buildDigits(int value) {
    return value
        .toString()
        .split('')
        .map((digit) => Text(
              digit,
              style: TextStyles.splashBigBoldWhiteText, // Use your custom style here
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: _buildDigits(_pointsAnimation.value),
      ),
    );
  }
}
