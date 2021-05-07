import 'dart:async';

import 'package:flutter/material.dart';

class ScaleAnimation extends StatefulWidget {
  final int duration;
  final Widget child;
  final Alignment alignment;
  final Duration timeDuration, delay;
  final bool repeat;

  const ScaleAnimation(
      {Key key,
      this.duration,
      this.child,
      this.alignment,
      this.timeDuration,
      this.delay,
      this.repeat = false})
      : assert(!(duration != null && timeDuration != null), ''),
        super(key: key);
  @override
  _ScaleAnimationState createState() => _ScaleAnimationState();
}

class _ScaleAnimationState extends State<ScaleAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.timeDuration != null
          ? widget.timeDuration
          : widget.duration != null
              ? Duration(seconds: widget.duration ?? 2)
              : Duration(milliseconds: 1500),
      vsync: this,
      lowerBound: 0.0,
      upperBound: 1.0,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut, //Curves.easeOutQuint,
    );
    // if (widget.repeat)
    //   _controller.repeat(reverse: true, min: 0.1);
    // else
    //   _controller.animateTo(1, curve: Curves.fastOutSlowIn);
    Timer(
      widget.delay ?? Duration(milliseconds: 200),
      () {
        try {
          if (widget.repeat)
            _controller.repeat(reverse: true, min: 0);
          else
            _controller.animateTo(1, curve: Curves.fastOutSlowIn);
        } catch (err) {}
      },
    );
  }

  @override
  void dispose() {
    _controller.stop();

    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _animation,
      child: widget.child,
    );
  }
}
