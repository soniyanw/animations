import 'package:flutter/material.dart';

class Pin extends AnimatedWidget {
  const Pin({Key? key, required Animation<Offset> listenable})
      : super(key: key, listenable: listenable);

  Animation<Offset> get _animation => listenable as Animation<Offset>;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Transform.translate(
        offset: _animation.value,
        child: Container(
          height: 80,
          width: 80,
          child: Center(
            child: RotatedBox(
              quarterTurns: 3,
              child: Icon(
                Icons.pin_drop_rounded,
                size: 80,
              ),
            ),
          ),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        ),
      );
    });
  }
}
