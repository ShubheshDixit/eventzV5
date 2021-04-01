import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

enum AnimationType { opacity, translateY }

class FadeAnimation extends StatelessWidget {
  final double delay;
  final Widget child;
  final double opacityBegin, translateYBegin;

  const FadeAnimation(this.delay, this.child,
      {this.opacityBegin, this.translateYBegin});

  @override
  Widget build(BuildContext context) {
    final tween = MultiTween<AnimationType>()
      ..add(
        AnimationType.opacity,
        Tween(begin: opacityBegin ?? 0.0, end: 1.0),
        Duration(milliseconds: 500),
      )
      ..add(
        AnimationType.translateY,
        Tween(begin: translateYBegin?.toDouble() ?? 50.0, end: 1.0),
        Duration(milliseconds: 500),
      );

    return PlayAnimation<MultiTweenValues<AnimationType>>(
      delay: Duration(milliseconds: (500.0 * delay?.toDouble()).round()),
      duration: tween.duration,
      tween: tween,
      child: child,
      builder: (context, child, value) => Opacity(
        opacity: value.get(AnimationType.opacity),
        child: Transform.translate(
          offset: Offset(
            0,
            value.get(AnimationType.translateY),
          ),
          child: child,
        ),
      ),
    );
  }
}
