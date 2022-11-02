import 'package:flutter/material.dart';

class Ball extends AnimatedWidget {
  const Ball({Key? key, required Animation<Offset> listenable})
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
            child: Icon(
              Icons.sports_baseball_sharp,
              size: 60,
            ),
          ),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        ),
      );
    });
  }
}
