import 'dart:math';

import 'package:flutter/material.dart';

class FlipCardController {
  FlipCardWidgetState? _state;

  Future flipCard(isFront) async => _state?.flipCard(isFront);
}

class FlipCardWidget extends StatefulWidget {
  FlipCardWidget({
    super.key,
    required this.flipCardController,
    required this.front,
    required this.back,
  });
  FlipCardController flipCardController;
  Widget front;
  Widget back;

  @override
  State<FlipCardWidget> createState() => FlipCardWidgetState();
}

class FlipCardWidgetState extends State<FlipCardWidget>
    with TickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    widget.flipCardController._state = this;
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
      value: 0,
    );
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  Future flipCard(bool isFront) async {
    isFront
        ? await animationController.forward()
        : await animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: animationController,
        builder: (context, child) {
          var angle = animationController.value * -pi;
          var transform = Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateY(angle);
          return Transform(
            alignment: Alignment.center,
            transform: transform,
            child: isFrontWidget(angle.abs())
                ? widget.front
                : Transform(
                    transform: Matrix4.identity()..rotateY(pi),
                    alignment: Alignment.center,
                    child: widget.back,
                  ),
          );
        });
  }

  bool isFrontWidget(double angle) {
    var degrees90 = pi / 2;
    var degrees270 = 3 * pi / 2;
    return angle <= degrees90 || angle >= degrees270;
  }
}
